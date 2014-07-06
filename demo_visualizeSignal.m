%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EXAMPLE: demo_visualizeSignal(visual,predefined,predefsignal)
% Converts data from webdemo for visualizeSignal

function demo_visualizeSignal(visual,predefined,predefsignal,uploadfile,filename)


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % BEGIN prepare parameters for array
      
    
    % check if own or predefined signal
    if (predefined == 1)
        if (predefsignal == 'wifi')
            inputFileLocation = 'eduroam_ch1.mat';
        elseif (predefsignal == 'signal1')
            echo "test";
        elseif (predefsignal == 'signal2')
            echo "test";
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
        echo "test";
    end
        
    % combine commands to modulearray
    ModuleArray = [filter; vis];
    
    visualizeSignal(inputFileLocation,1,ModuleArray);
    
end
% END main function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%