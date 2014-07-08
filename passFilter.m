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
    
    % check if enough parameters
    if ~(argsLength == 4)
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
    [rows, columns] = size(inputSignal);
    frequencySignal = abs(linspace(-sampleRate/2,sampleRate/2,columns));

    % END check input parameters for consistency
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % BEGIN signal processing

    % low pass
    if (filterType == 1)
        valueSignal(frequencySignal>limitFrequency1) = 0;
    % high pass
    elseif (filterType == 2)
        valueSignal(frequencySignal<limitFrequency1) = 0;
    % bandpass
    elseif (filterType == 3)
        valueSignal(frequencySignal<limitFrequency1) = 0;
        valueSignal(frequencySignal>limitFrequency2) = 0;
    end
   
    %get both together
    outputSignal = [sampleRate valueSignal];
    
    % END signal processing
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
end
