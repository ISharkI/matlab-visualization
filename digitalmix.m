function [ output ] = digitalmix( input )
%UNTITLED3 Summary of this function goes here
%   mixes up by the given frequency dist for dir==0 or down otherwise

argsLength=input(1,1);


yin=input(2,argsLength+2:end);

if argsLength<3
    error('parameter missing')
end
%get the parameters
dir=input(1,2);
dist=input(1,3);
srin=input(1,4);
if(dir==0)
    q=(1/srin);
    p=dist+q;
elseif (dir==1)
    q=(1/srin);
    p=q-(dist);
else
    error('parameter out of range');
end
[p,q]=rat(p/q)

%resample

yout=resample(yin,p,q);
%create output
output=[srin*q/p yout];




end

