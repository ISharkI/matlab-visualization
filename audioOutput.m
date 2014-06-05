%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Part of visualizeSignal
% Outputs the signal using the pc speakers with no return value. The Script assumes the signal is handed over as time domain.
%
% EXAMPLE: audioOutput(InputArray)
% Parameters
%   inputArray              % defines input array containing parameters and signal
% 
% Parameters in array:
% no parameters needed



% BEGIN, main function (audioOutput)
function audioOutput(inputSignal)

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % BEGIN check input parameters for consistency
    
    % check if file exists
    if ~exist('inputSignal','var')
        error('ERROR: No Signal defined!');
    end
    
    % get parameters
    argsLength = inputSignal(1);
    
    % check if enough parameters
    if (argsLength == 0)
        error('ERROR: Not enough parameters at audioOutput module!');
    elseif (argsLength > 0)
        error('ERROR: Too much parameters at audioOutput module!');
    end
    sampleDist=inputSignal(2);
    % remove parameter column
    inputSignal = inputSignal(argsLength+2:end);
    
    % END check input parameters for consistency
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % BEGIN signal processing
    
    % get sample frequency
    y=inputSignal;
    samplerate = 1/(sampleDist);

    % tune down your speakers baby
    sound(y,samplerate);
    
    % END signal processing
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
end
