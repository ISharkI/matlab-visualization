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
    
    load(inputFileLocation);
    
    % check if file is correct
    % this means it contains two vertical arrays v (values) and t (time)
    
    if ~exist('t','var') || ~exist('v','var')
        error('ERROR: Found no valid input File!');
    else
        dimt = size(t);
        dimv = size(v);
        if (dimt(2) > 1 || dimv(2) > 1 || dimt(1) ~= dimv(1))
            error('ERROR: Found no valid input File!');
        end
    end
    
    % return signal
    signal = [rot90(t);rot90(v)];
    
    % load file
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end