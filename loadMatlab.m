%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EXAMPLE: visualizeSignal("inputFileLocation", [loaderModuleNumber], [FilterModuleArray, OutputModuleArray])
% Parameters
%   inputFileLocation,              % defines location of file to load
% 
% Optional Parameters
%   loaderModuleNumber,             % number of loader module
%   FilterModuleArray,              % single line array of filters to be executed
%   OutputModuleArray               % single line array of output methods

% examples
% display input signal from m file: visualizeSignal(example.m)
% display signal after low pass:    visualizeSignal(1, example.m, [2], [1])

% BEGIN, main function (supervisor)
function visualizeSignal(
    inputFileLocation,
    loaderModuleNumber;
    FilterModuleArray,
    OutputModuleArray
)