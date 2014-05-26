function [ output ] = digitalmix( input )
%UNTITLED3 Summary of this function goes here
%   mixes up by the given frequency dist for dir==0 or down otherwise

argsLength=input(1,1);

%y-Achse
xin=input(1,argsLength+2:end);
%x-Achse
yin=input(2,argsLength+2:end);

if argsLength<2
    error('parameter missing')
end
%get the parameters
dir=input(1,2);
dist=input(1,3);
if(dir==0)
    q=(1/(xin(2)-xin(1)));
    p=dist+q;
elseif (dir==1)
    q=(1/(xin(2)-xin(1)));
    p=q-(dist);
else
    error('parameter out of range');
end
[p,q]=rat(p/q)

%resample
xout=resample(xin,p,q);
yout=resample(yin,p,q);
%create output
output=[xout;yout];




end

