%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EXAMPLE: visualizeSignal("inputFileLocation", [ModuleArray], [loaderModuleNumber], [sampleRate])
% Parameters
%   inputFileLocation               defines location of file to load
% 
% Optional Parameters
%   ModuleArray                     array of output modules, filters and their values to be executed
%                                   each row consists out ouf one column
%                                   for the output/filter and the following columns for the
%                                   parameters
%   loaderModuleNumber              number of loader module (optional, if no number is given "1" will be assumed)
%   samplerate                      samplerate of the signal (mandatory for the CSV-loader, otherwise ignored)

% examplesy
% display input signal from example file as time domain: visualizeSignal(example.m)

% BEGIN, main function (supervisor)
function visualizeSignal(inputFileLocation,ModuleArray,loaderModuleNumber,samplerate)


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % BEGIN check input parameters for consistency
    
    % check if loader is chosen and set matlab loader if not given
    if ~exist('loaderModuleNumber','var')
        loaderModuleNumber = 1;
    end
    
    % check if samplerate is set, assume default sample rate 44100 (audio) if not
    if loaderModuleNumber == 2 
        if ~exist('samplerate','var')
            error('ERROR: No samplerate found!');
        end
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
            
        % CSV files
        case 2
            loaded = loadCsv(inputFileLocation);
            signal=loaded;
            
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
                h = datestr(clock,0);
                savename = [h(1:11),'-',h(13:14),'-',h(16:17),'-',h(19:20)];
                saveas(myplot,strcat(savename,'-Plot'),'fig');
                saveas(myplot,strcat(savename,'-Plot'),'jpg');
                % save signal
                save(strcat(savename,'-Signal.mat'),'sampleDist','signal');              
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
                %parameter targ is for second signal(0=autocorr, 1=shortt,
                %2=longt)
                targ=ModuleArray(i,2);
                % correlate with what?
                
                % presently only autocorrelation
                inputsignal=[num targ signal];
                signal=correlation(inputsignal);
            case 12
                % set number of arguments
                num=3;
                type=ModuleArray(i,2);
                fig=ModuleArray(i,3);
                inputsignal=[num type fig sampleDist signal];
                plotIQ(inputsignal); 
            case 13
                num=1;
                signal=findSignal([num sampleDist signal]);
            case 14
                % set number of arguments
                num =1;
                %parameter targ is for second signal(0=autocorr, 1=shortt,
                %2=longt)
                targ=ModuleArray(i,2);
                % correlate with what?
                
                % presently only autocorrelation
                inputsignal=[num targ signal];
                signal=findCorrelation(inputsignal);

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