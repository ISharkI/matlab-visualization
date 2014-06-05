function [ output ] = correlation( input )
%UNTITLED Summary of this function goes here
%   1 'length of signal 1' [signal 1] [signal 2]
argsLength=input(1);
if (argsLength==0)
    error('not enough arguments');
end
length1=input(2);
sig1=input(argsLength+2:argsLength+1+length1);
sig2=input(argsLength+2+length1:end);
output=xcorr(sig1,sig2);

end

