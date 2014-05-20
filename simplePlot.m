function [  ] = simplePlot(  input )
%UNTITLED Summary of this function goes here
%   Currently uses two Parameter: 
%   type (0= standard, 1=fourier transformed signal)
%   plotNumber (determines in which figure the plot will be drawn)

% check the number of parameters
argsLength=input(1,1);

% check if t least one parameter exists
if argsLength>=2
    type=input(1,2);
    plotNumber=input(1,3);
    

    %y-Achse
    x=input(1,argsLength+2:end);
    %x-Achse
    y=input(2,argsLength+2:end);
    
    %zeitbereich
    if (type==0)
        
           
    %frequenzbereich
    elseif(type==1)
        y=abs(y);
        
    else
        error('parameter out of range');
    end
    
    %plot it in the right figure
    figure (plotNumber);
    plot(x,y)   
    if (type==0)
        xlabel('t in seconds');
    elseif (type==1)
         xlabel('f in Hertz');  
    else
        error('parameter out of range')
    end
    
end
end

