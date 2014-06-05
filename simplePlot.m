function [  ] = simplePlot(  input )
%UNTITLED Summary of this function goes here
%   Currently uses two Parameter: 
%   type (0= standard, 1=fourier transformed signal)
%   plotNumber (determines in which figure the plot will be drawn)

% check the number of parameters
argsLength=input(1,1);

% check if t least one parameter exists
if argsLength>=3
    type=input(2);
    plotNumber=input(3);
    srin=input(4);
    

    %y-Achse
    y=input(argsLength+2:end);
    %x-Achse

    
    
    
    %zeitbereich
    if (type==0)
        x=linspace(0,length(y)*srin,length(y));
           
    %frequenzbereich
    elseif(type==1)
        y=abs(y);
        x=0.5*srin*linspace(-1,1,length(y));
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

