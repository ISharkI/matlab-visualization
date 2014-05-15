function [  ] = simplePlot(  input )
%UNTITLED Summary of this function goes here
%   Currently uses one Parameter: type

% abfragen der parameter anzahl, hier 1 (zeit oder frequenzbereich)
argsLength=input(1,1);

        %arbeite nur das array ab, wenn die argumente existieren
if argsLength>=1
    type=input(2,1);

    %y-Achse
    x=input(1,argsLength+1:end);
    %x-Achse
    y=input(2,argsLength+1:end);
    
    %zeitbereich
    if (type==0)
        
           
    %frequenzbereich
    elseif(type==1)
        y=abs(y);
        
    else
        error('Fehler');
    end
    
    %plot it
    plot(x,y)   
    if (type==0)
        xlabel('t');
    elseif (type==1)
         xlabel('f');  
    end
    
end
end

