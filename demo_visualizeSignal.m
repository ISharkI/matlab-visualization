%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EXAMPLE: demo_visualizeSignal(visual,predefined,predefsignal)
% Converts data from webdemo for visualizeSignal

function demo_visualizeSignal(visual,predefined,predefsignal,samplerate,pass,passfilter,passlow,passhigh,mixing,mixfreq,uploadfile,filename)

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
      
    % check if samplerate is set, assume default sample rate 44100 (audio) if not
    % set
    if ~exist('samplerate','var')
        samplerate = 0.00002;
    else
        samplerate = 1/samplerate;
    end
    
    % check if own or predefined signal
    
    if (predefined == 1)
        if (strcmp(predefsignal,'wifi'))
            inputFileLocation = 'eduroam_ch1.mat';
        elseif (strcmp(predefsignal,'signal1'))
            inputFileLocation = 'signal1';
        elseif (strcmp(predefsignal,'signal2'))
            inputFileLocation = 'signal2';
        else
            inputFileLocation = 'eduroam_ch1.mat';
        end
    else
        inputFileLocation = uploadfile;
    end
    
    % get filters
    % default delay... doesn't hurt anyone to wait
    filter = [1 0 0 0 0 0 0];
    
    % passfilter
    if (pass == 1)
        if (strcmp(passfilter,'low'))
            filter = [filter; 6 1 passlow 0 0 0 0;];
        elseif (strcmp(passfilter,'high'))
            filter = [filter; 6 2 passhigh 0 0 0 0;];
        elseif (strcmp(passfilter,'band'))
            filter = [filter; 6 3 passlow passhigh 0 0 0;];
        end
    end
        
    % highlight signal
    if (mixing == 1)
        filter = [filter; 10 0 mixfreq 0 0 0 0;];
    end
    
    % check form of visualization0
    if (strcmp(visual,'time'))
        vis = [2 0 1 0 0 0 0];
    elseif (strcmp(visual,'freq'))
        filter = [filter; 3 0 0 0 0 0 0];
        vis = [2 1 1 0 0 0 0];
    elseif (strcmp(visual,'iq'))
        filter = [filter; 3 0 0 0 0 0 0];
        vis = [12 0 0 0 0 0 0];
    else
        vis = [2 0 1 0 0 0 0];
    end
        
    % combine commands to modulearray
    ModuleArray = [filter; vis];
    
     % END prepare parameters for array
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%%%%%%%%%
   
    if (predefined == 1)
        visualizeSignal(ModuleArray,inputFileLocation,1);
    else
        visualizeSignal(ModuleArray,inputFileLocation,2,samplerate);
    end
    
    %How to save the last shown plot?
    %saveas(myplot,filename,'jpg');
    print(filename, '-dgif','-S640,480', '-r0');

end
% END main function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%