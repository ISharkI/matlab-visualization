%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Part of visualizeSignal
% Returns signal after filter as a array
%
% EXAMPLE: delayFilter(inputSignal)
% Parameters
%   inputSignal              % defines input signal
% 

% BEGIN, main function (delayFilter)
function outputSignal = delayFilter(inputSignal)

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % BEGIN check input parameters for consistency
    
    % check if file exists
    if ~exist('inputSignal','var')
        error('ERROR: No Signal defined!');
    end
    
    % END check input parameters for consistency
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % BEGIN signal processing
    
    % this is just a delay filter which means there is no change to the
    % signal
    
    outputSignal = inputSignal;
    
    % END signal processing
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
end
