function [ out ] = plotIQ( input )
%UNTITLED3 Summary of this function goes here
%   parameters: type of domain, desired figure (where the plot is to be
%   drawn), sample rate
argsLength=input(1);
if (argsLength<3)
    error('not enough parameters');
end
type=input(2);
fig=input(3);
sr=input(4);
sig=input(argsLength+2:end);
figure(fig);
realsig=real(sig);
imsig=imag(sig);
out=figure;
scatterplot(sig);
end

