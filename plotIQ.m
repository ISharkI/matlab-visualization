function [ out ] = plotIQ( input )
%UNTITLED3 Summary of this function goes here
%   parameters: type of domain, desired figure (where the plot is to be
%   drawn), sample rate
argsLength=input(1);


sig=input(argsLength+2:end);

%ret=figure(fig);
realsig=real(sig);
imsig=imag(sig);
scatterplot(sig);
%out=ret;
end

