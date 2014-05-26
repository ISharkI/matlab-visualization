%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Part of visualizeSignal
% Returns and plots an power spectrum. The Script assumes the signal is handed over as time domain.
%
% EXAMPLE: powerSpectrum(InputArray)
% Parameters
%   inputArray              % defines input array containing parameters and signal
% 
% Parameters in array:
% no parameters needed



% BEGIN, main function (energySpectrum)
function outputSignal = powerSpectrum(inputSignal)

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % BEGIN check input parameters for consistency
    
    % check if file exists
    if ~exist('inputSignal','var')
        error('ERROR: No Signal defined!');
    end
    
    % get parameters
    argsLength = inputSignal(1,1);
    
    % check if enough parameters
    if ~(argsLength == 0)
        error('ERROR: To much parameters at powerSpectrum module!');
    end
    
    % remove parameter column
    inputSignal = inputSignal(:,argsLength+2:end);
    
    % END check input parameters for consistency
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % BEGIN signal processing
    
    % get sample frequency    
    samplerate = 1/(inputSignal(2,1)-inputSignal(1,1));
    dim=size(inputSignal);
    
    % gogo gadgetospectrum
    nfft = 2^nextpow2(dim(2));
    y=inputSignal(2,:);
    spectrum = abs(fft(y,nfft)).^2/dim(2)/samplerate;
    
    % Create a single-sided spectrum
    outputSignal = dspdata.psd(spectrum(1:length(spectrum)/2),'Fs',samplerate);  
    plot(outputSignal);
    % END signal processing
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
end
