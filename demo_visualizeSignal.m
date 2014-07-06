%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EXAMPLE: demo_visualizeSignal(visual,predefined,predefsignal)
% Converts data from webdemo for visualizeSignal

function demo_visualizeSignal(visual,predefined,predefsignal,uploadfile,filename)

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % BEGIN, set up graphical output

    % Create an invisible figure.
    if (webdemo_en)
      fig = figure(1); set(fig, 'visible', 'off');
    else
      fig = figure(1); set(fig, 'visible', 'on');
    end

    landscape = '-S930,350';
    portrait  = '-S640,480';

    output_format = landscape; %portrait;     % default


    set(0, 'defaultlinelinewidth', 2);

    if (webdemo_en)
      set(0, 'defaultaxesfontsize', 12);
      set(0, 'defaultaxesfontname', 'Arial');
      set(0, 'defaulttextfontsize', 12);
      set(0, 'defaulttextfontname', 'Arial');
      const_lw = 2;
    elseif (svg_en)
      set(0, 'defaultaxesfontsize', 6);
      set(0, 'defaultaxesfontname', 'Arial');
      set(0, 'defaulttextfontsize', 6);
      set(0, 'defaulttextfontname', 'Arial');
      const_lw = 1;
    else
      set(0, 'defaultaxesfontsize', 10);
      set(0, 'defaultaxesfontname', 'Arial');
      set(0, 'defaulttextfontsize', 8);
      set(0, 'defaulttextfontname', 'Arial');
      const_lw = 2;
    end

    % END, set up graphical output
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % BEGIN prepare parameters for array
      
    
    % check if own or predefined signal
    if (predefined == 1)
        if (predefsignal == 'wifi')
            inputFileLocation = 'eduroam_ch1.mat';
        elseif (predefsignal == 'signal1')
            echo 'test';
        elseif (predefsignal == 'signal2')
            echo 'test';
        end
    else
        inputFileLocation = uploadfile;
    end
    
    % get filters
    % test
    filter = [1 0 0 0 0 0 0];
    
    % check form of visualization
    if (visual == 'time')
        vis = [2 0 1 0 0 0 0];
    elseif (visual == 'freq')
        vis = [2 1 1 0 0 0 0];
    elseif (visual == 'iq')
        echo 'test';
    end
        
    % combine commands to modulearray
    ModuleArray = [filter; vis];
    
     % END prepare parameters for array
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
    
    filename_output = visualizeSignal(inputFileLocation,1,ModuleArray);
    
    
    print(filname_output, '-dgif','-S640,480', '-r0');

    if (svg_en)
      print(['fig_',filname_output], '-dsvg',output_format);
    endif

end
% END main function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%