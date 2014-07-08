function [ output ] = digitalmix( input )
%UNTITLED3 Summary of this function goes here
%   mixes up by the given frequency dist for dir==0 or down otherwise
%   Signal must be frequency domain

argsLength=input(1);


yin=input(argsLength+2:end);

if argsLength<3
    error('parameter missing')
end
%get the parameters
dir=input(2);
dist=input(3);
srin=input(4);
[width,length]=size(yin);
%add zeros before or after the signal
if(dir==0)
    yout=[zeros([1,floor(dist/(srin)*length)]) yin];   
    yout=yout(1:length);
    %srin=srin+dist;
else
    yout=[ yin zeros([1,floor(dist/(srin)*length)])];
    [newWidth, newLength]=size(yout);
    tocut=(newLength-length);
    yout=yout(1+tocut:end);
    %srin=srin+dist;

end

%create output
output=[srin yout];




end

