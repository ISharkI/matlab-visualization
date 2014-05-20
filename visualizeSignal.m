%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EXAMPLE: visualizeSignal("inputFileLocation", [loaderModuleNumber], [ModuleArray])
% Parameters
%   inputFileLocation               defines location of file to load
% 
% Optional Parameters
%   loaderModuleNumber              number of loader module
%   ModuleArray                     array of output modules, filters and their values to be executed
%                                   each row consists out ouf one column
%                                   for the output/filter and the following columns for the
%                                   parameters

% examplesy
% display input signal from m file: visualizeSignal(example.m)
% display signal after low pass:    visualizeSignal(1, example.m, [2 1])

% BEGIN, main function (supervisor)
function visualizeSignal(inputFileLocation,loaderModuleNumber,ModuleArray)


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % BEGIN check input parameters for consistency
    
    % check if loader is chosen and set matlab loader if not given
    if ~exist('loaderModuleNumber','var')
        loaderModuleNumber = 1;
    end
    
    % check if array is set
    if ~exist('ModuleArray','var')
        ModuleArray = [2 0 1];
    end
    
    % check if file exists
    if (exist('inputFileLocation', 'file') ~= 2) == 0
        error('ERROR: Found no input File!');
    end
    
    % END check input parameters for consistency
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    % BEGIN to access loader
    
    switch loaderModuleNumber
        % Matlab files
        case 1
            signal = loadMatlab(inputFileLocation);
        % kill script if invalid input occurs
        otherwise
            error('ERROR: No valid loader specified!');
    end
    
    % END to access loader
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    % BEGIN to access filter and output

    for i=1:size(ModuleArray,1)
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
        % BEGIN to access filter/output
        
        switch ModuleArray(i,1)
            % delay filter
            case 1
                % no arguments needed
                signal = delayFilter(signal);
            
            % time/frequency plot
            case 2
                % set number of arguments
                num = [2;0];
                % get argument which plot type
                type = [ ModuleArray(i,2);  0];
                % get argument which figure
                figure =[ModuleArray(i,3);0];
                inputsignal = [num type figure signal];
                simplePlot(inputsignal);
            % fft or ifft
            case 3
                % set number of arguments
                num = [1;0];
                %parameter type
                type = [ ModuleArray(i,2);  0];
                inputsignal = [num type signal];
                signal=fourier(inputsignal);
            % blockwise fft
            case 4
                % set number of arguments
                num = [1;0];
                %parameter block length
                length=[ ModuleArray(i,2);  0];
                inputsignal=[num length signal];
                signal=fourierBlocks(inputsignal);
            % cutout
            case 5
                % set number of arguments
                num = [2;0];
                %parameter start_sample
                start_sample=[ ModuleArray(i,2);  0];
                %parameter end_sample
                end_sample=[ ModuleArray(i,3);  0];
                inputsignal=[num start_sample end_sample signal];
                signal=fourierBlocks(inputsignal);
        %   case 4
        %       % add arguments (limitfrequency)
        %       params = [ 1 ModuleArray(i,3); 0 0];
        %       signal = [ params signal];
        %       signal = highFilter(signal);
            % kill script if invalid input occurs
            otherwise
                error('ERROR: No valid filter at position' + i + 'specified!');
        end
        %testoutput
        %size(signal)
        %t = signal(1,:);
        %v = signal(2,:);
        %plot(t,v)
                
        % END access filter/output
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

    end
    
    % END to access filter and output
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    
end
% END main function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%