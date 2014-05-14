%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Part of visualizeSignal
% Returns content of source file as a array
%
% EXAMPLE: loadMatlab("inputFileLocation")
% Parameters
%   inputFileLocation,              % defines location of file to load
% 

% BEGIN, main function (loadMatlab)
function signal = loadMatlab(inputFileLocation)

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % BEGIN check input parameters for consistency
    
    % check if file exists
    if (exist('inputFileLocation', 'file') ~= 2) == 0
        error('ERROR: Found no input File!');
    end
    
    % END check input parameters for consistency
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % BEGIN load file
    [signal] = [10 1 2 3 4 5 6]
    %what now?
end