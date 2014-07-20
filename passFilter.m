%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Part of visualizeSignal
% Returns signal after applying a pass filter (lowpass, highpass,
% bandpass). The Script assumes the signal is handed over as frequency
% domain.
%
% EXAMPLE: passFilter(InputArray)
% Parameters
%   inputArray              % defines input array containing parameters and signal
% 
% Parameters in array:
% 1. Variant of Filter
%       1 - lowpass
%       2 - highpass
%       3 - bandpass
% 2. Lower limit frequency in Hz
% 3. Higher limit frequency in Hz (for bandpass only, ignored if low or highpass)

% BEGIN, main function (passFilter)
function outputSignal = passFilter(inputSignal)

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % BEGIN check input parameters for consistency
    
    % check if file exists
    if ~exist('inputSignal','var')
        error('ERROR: No Signal defined!');
    end

    % get parameters
    argsLength = inputSignal(1);
    filterType = inputSignal(2);
    sampleRate = inputSignal(5);
    domain=inputSignal(6);
    if (domain==0)
        sampleRate=1/sampleRate;
    end
    
    % check if enough parameters
    if ~(argsLength == 5)
        error('ERROR: Not enough parameters at passFilter module!');
    end
    
    % check if valid mode
    if ~(filterType == 1 || filterType == 2 || filterType == 3)
        error('ERROR: Invalid mode at passFilter module!');
    end
        
        
    % get limit frequency
    limitFrequency1 = inputSignal(3);
    limitFrequency2 = inputSignal(4);
    
    %check if 2>1
    if (filterType == 2 && ~(limitFrequency1 < limitFrequency2))
       error('ERROR: Frequency 2 is lower than Frequency 1 at passFilter module!');
    end
    
    % get signal
    valueSignal = inputSignal(argsLength+2:end);
    [~, columns] = size(valueSignal);
    

    % END check input parameters for consistency
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % BEGIN create Filter
    
    % low pass
    if (filterType == 1)
        
        Fs = sampleRate;  % Sampling Frequency

        Fpass = limitFrequency1;            % Passband Frequency
        Fstop = Fpass*1.2;           % Stopband Frequency
        Dpass = 0.057501127785;  % Passband Ripple
        Dstop = 0.0001;          % Stopband Attenuation
        flag  = 'scale';         % Sampling Flag

        % Calculate the order from the parameters using KAISERORD.
        [N,Wn,BETA,TYPE] = kaiserord([Fpass Fstop]/(Fs/2), [1 0], [Dstop Dpass]);

        % Calculate the coefficients using the FIR1 function.
        b  = fir1(N, Wn, TYPE, kaiser(N+1, BETA), flag);
        Hd = dfilt.dffir(b);
    % high pass
    elseif (filterType == 2)
        Fs = sampleRate;  % Sampling Frequency

        Fstop = limitFrequency1/1.2;            % Stopband Frequency
        Fpass = limitFrequency1;           % Passband Frequency
        Dstop = 0.0001;          % Stopband Attenuation
        Dpass = 0.057501127785;  % Passband Ripple
        flag  = 'scale';         % Sampling Flag

        % Calculate the order from the parameters using KAISERORD.
        [N,Wn,BETA,TYPE] = kaiserord([Fstop Fpass]/(Fs/2), [0 1], [Dpass Dstop]);

        % Calculate the coefficients using the FIR1 function.
        b  = fir1(N, Wn, TYPE, kaiser(N+1, BETA), flag);
        Hd = dfilt.dffir(b);
    % bandpass
    elseif (filterType == 3)
        Fs = sampleRate;
        Fstop1 = limitFrequency1/1.2;            % First Stopband Frequency
        Fpass1 = limitFrequency1;            % First Passband Frequency
        Fpass2 = limitFrequency2;           % Second Passband Frequency
        Fstop2 = limitFrequency2*1.2;           % Second Stopband Frequency
        Dstop1 = 0.0001;           % First Stopband Attenuation
        Dpass  = 0.057501127785;  % Passband Ripple
        Dstop2 = 0.0001;          % Second Stopband Attenuation
        flag   = 'scale';         % Sampling Flag

        % Calculate the order from the parameters using KAISERORD.
        [N,Wn,BETA,TYPE] = kaiserord([Fstop1 Fpass1 Fpass2 Fstop2]/(Fs/2), [0 ...
                                     1 0], [Dstop1 Dpass Dstop2]);

        % Calculate the coefficients using the FIR1 function.
        b  = fir1(N, Wn, TYPE, kaiser(N+1, BETA), flag);
        Hd = dfilt.dffir(b);

        
    end
    if(domain==0)
    valueSignal=filter(Hd,valueSignal);
    %frequency domain
    else
        %generate symmetric transmission function from filter
    transmission=freqz(Hd,columns/2)';
    transmissionflip=fliplr(transmission);
    transmission=[transmissionflip transmission]; 
    %apply filter
    valueSignal=valueSignal.*transmission;
    
    end
    
    outputSignal = valueSignal;
    
    % END signal processing
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
end
