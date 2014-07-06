%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EXAMPLE: demo_visualizeSignal(visual,predefined,predefsignal)
% Converts data from webdemo for visualizeSignal

function demo_visualizeSignal(visual,predefined,predefsignal,uploadfile,filename)

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % BEGIN, set up graphical output

    % Create an invisible figure.
    fig = figure(1); set(fig, 'visible', 'on');
    
    landscape = '-S930,350';
    portrait  = '-S640,480';

    output_format = landscape; %portrait;     % default


    set(0, 'defaultlinelinewidth', 2);
    set(0, 'defaultaxesfontsize', 10);
    set(0, 'defaultaxesfontname', 'Arial');
    set(0, 'defaulttextfontsize', 8);
    set(0, 'defaulttextfontname', 'Arial');
    const_lw = 2;

    % END, set up graphical output
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % BEGIN prepare parameters for array
      
    
    % check if own or predefined signal
    if (predefined == 1)
        if (predefsignal == 'wifi')
            inputFile = 'eduroam_ch1.mat';
        elseif (predefsignal == 'signal1')
            echo 'test';
        elseif (predefsignal == 'signal2')
            echo 'test';
        end
    else
        inputFile = uploadfile;
    end
    
    % get filters
    % test
    filter = [1 0 0 0 0 0 0];
    
    % check form of visualization
    if (visual == 'time')
        vis = [7 0 1 0 0 0 0];
    elseif (visual == 'freq')
        vis = [7 1 1 0 0 0 0];
    elseif (visual == 'iq')
        echo 'test';
    end
        
    % combine commands to modulearray
    ModArray = [filter; vis; 0 0 0 0 0 0 0];
    
     % END prepare parameters for array
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
    
    visualizeSig(inputFile,1,ModArray,filename);
end
% END demo function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
function visualizeSig(inputFileLocation,loaderModuleNumber,ModuleArray,filename)


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
            loaded = loadMatlab(inputFileLocation);
            signal=loaded(2:end);
            sampleDist=loaded(1);
            
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
            case 0
                % saves last Plot and signal, so not really a module
                % save signal
                saveas(myplot,filename,'png');
                % delay filter
            case 1
                % no arguments needed'signal.mat'
                signal = delayFilter(signal);
            
            % time/frequency plot
            case 2
                % set number of arguments
                num = 3;
                % get argument which plot type
                type =  ModuleArray(i,2);
                % get argument which figure
                fig =ModuleArray(i,3);
                inputsignal = [num type fig sampleDist signal];
                simplePlot(inputsignal);
            % fft or ifft
            case 3
                % set number of arguments
                num = 2;
                %parameter type
                type =  ModuleArray(i,2);
                inputsignal = [num type sampleDist signal];
                result=fourier(inputsignal);
                signal=result(2:end);
                sampleDist=result(1);
            % blockwise fft
            case 4
                % set number of arguments
                num = 3;
                %parameter block length
                length=ModuleArray(i,2);
                % parameter figure
                fig=ModuleArray(i,3);
                inputsignal=[num length fig sampleDist signal];
                fourierBlocks(inputsignal);
            % cutout
            case 5
                % set number of arguments
                num = 2;
                %parameter start_sample
                start_sample= ModuleArray(i,2);
                %parameter end_sample
                end_sample=ModuleArray(i,3);
                inputsignal=[num start_sample end_sample signal];
                signal=cutout(inputsignal);
            % pass filter
            case 6
                % set number of arguments
                num = 4;
                % type
                type = ModuleArray(i,2);
                % parameter low frequency in Hz
                lowfreq=ModuleArray(i,3);
                % parameter high frequency in Hz
                highfreq=ModuleArray(i,4);
                inputsignal=[num type lowfreq highfreq sampleDist signal];
                result=passFilter(inputsignal);
                signal=result(2:end);
                sampleDist=result(1);
            % power spectrum
            case 7
                % set number of arguments
                num = 1;
                inputsignal=[num sampleDist signal];
                myplot=powerSpectrum(inputsignal);
            % audio output
            case 8
                % set number of arguments
                num = 1;
                inputsignal=[num sampleDist signal];
                audioOutput(inputsignal);
            % resampling (p/q)
            case 9
                % set number of arguments
                num=3;
                % parameter p
                p=ModuleArray(i,2);
                % parameter q
                q=ModuleArray(i,3);
                inputsignal=[num p q sampleDist signal];
                result=resampling(inputsignal);
                signal=result(2:end);
                sampleDist=result(1);
            case 10
                % set number of arguments
                num=3;
                % parameter direction (0 stands for up)
                dir=ModuleArray(i,2);
                % parameter "distance" in Hz
                dist=ModuleArray(i,3);
                inputsignal=[num dir dist sampleDist signal];
                result=digitalmix(inputsignal);
                signal=result(2:end);
                sampleDist =result(1);
            case 11
                % set number of arguments
                num =1;
                % get signal length
                dim=size(signal);
                le=dim(2);
                % presently only autocorrelation
                inputsignal=[num le signal signal];
                signal=correlation(inputsignal);
            case 12
                % set number of arguments
                num=3;
                type=ModuleArray(i,2);
                fig=ModuleArray(i,3);
                inputsignal=[num type fig sampleDist signal];
                plotIQ(inputsignal);   
            
                
        %   case 4
        %       % add arguments (limitfrequency)
        %       params = [ 1 ModuleArray(i,3); 0 0];
        %       signal = [ params signal];
        %       signal = highFilter(signal);
            % kill script if invalid input occurs
            otherwise
                error('ERROR: No valid filter at position' + i + 'specified!');
        end
                
        % END access filter/output
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

    end
    
    % END to access filter and output
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    
end
% END main function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%