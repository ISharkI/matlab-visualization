function [ output ] = digitalmix( input )
%UNTITLED3 Summary of this function goes here
%   Parameter: domain (0=time,1=frequency), delta f
%   mixes the signal up for positive delta f and down for negative delta f

argsLength=input(1);


yin=input(argsLength+2:end);

if argsLength<3
    error('parameter missing')
end
%get the parameters
dom=input(2);
val=input(3);
dist=abs(val);
dir=sign(val);
srin=input(4);
[width,length]=size(yin);
%time domain
if (dom==0)
    yout=yin.*exp(1i*2*pi*srin.*(1:length)*val);
else
%add zeros before or after the signal
if(dir==0)
    yout=[yin(1:floor(dist/(srin)*length)) yin];   
    yout=yout(1:length);
    %srin=srin+dist;
else
    yout=[ yin yin(1:floor(dist/(srin)*length))];
    [newWidth, newLength]=size(yout);
    tocut=(newLength-length);
    yout=yout(1+tocut:end);
    %srin=srin+dist;

end
end
%create output
output=[srin yout];




end

