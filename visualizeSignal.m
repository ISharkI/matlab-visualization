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
function visualizeSignal(inputFileLocation,loaderModuleNumber,FilterModuleArray,OutputModuleArray)


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % BEGIN check input parameters for consistency
    
    % check if loader is chosen and set matlab loader if not given
    if ~exist('loaderModuleNumber','var')
        loaderModuleNumber = 1;
    end
    
    % check if arrays are set and set defaults if not
    if ~exist('FilterModuleArray','var')
        FilterModuleArray = [1];
    end
    if ~exist('OutputModuleArray','var')
        OutputModuleArray = [1];
    end
    
    % check if arrays match in dimension
    [rf,cf] = size(FilterModuleArray);
    [ro,co] = size(OutputModuleArray);
    if ~(rf == 1 || ro == 1)
        error('ERROR: Array has more than 1 row!');
    end
    
    if ~(cf == co)
        error('ERROR: Arrays do not match in dimension!');
    end
    
    % check if file exists
    if (exist('inputFileLocation', 'file') ~= 2) == 0
        error('ERROR: Found no input File!','inputFileLocation');
    end
    
    % END check input parameters for consistency
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    % BEGIN to access loader
    
    switch loaderModuleNumber
        % Matlab files
        case 1
            signal = loadMatlab(inputFileLocation);
            %handle.signal = loadMatlab(inputFileLocation);
           
        % kill script if invalid input occurs
        otherwise
            error('ERROR: No valid loader specified!');
    end
    
    % END to access loader
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    % BEGIN to access filter and output

    for i=1:length(FilterModuleArray)
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
        % BEGIN to access filter
        
        switch i
            % delay filter
            case 1
                signal = delayFilter(signal);
            % kill script if invalid input occurs
            otherwise
                error('ERROR: No valid filter at position' + i + 'specified!');
        end
        
        % END to access filter
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    	% BEGIN to access output
        %
        %switch 
        %   % skip if unwanted
        %    case 0
        %       
        %   % time plot
        %    case 1
        %        plot = timePlot(signal);
        %    case 2
        %        plot = frequencyPlot(signal);
        %    % kill script if invalid input occurs
        %    otherwise
        %        error('ERROR: No valid output at position' + i + 'specified!');
        %end
        %
        % END access output
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

    end
    
    % END to access filter and output
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    
end
% END main function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%