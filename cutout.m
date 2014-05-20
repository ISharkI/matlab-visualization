function [ output ] = cutout( input )
%UNTITLED2 Summary of this function goes here
%   Cuts out a sequence from the input signal, depending on the input
%   signal

%retrieve parameters
argsLength=input(1,1);
if argsLength<2
    error('not enough parameters');
end
start_sample=input(1,2);
end_sample=input(1,3);
dim=size(input);
%test several mismatches
if start_sample<0 || start_sample>dim(2)-argsLength-1 ||end_sample<0 || end_sample>dim(2)-argsLength-1
    error('parameters out of range')
end
%begin to cut out
% normal case
if end_sample>start_sample
    output=input(:,start_sample+argsLength+1:end_sample+argsLength+1);
    % overflow
elseif end_sample<start_sample
    output=[input(:,end_sample+argsLength+1:end) input(:,argsLength+1:start_sample+argsLength+1)];
% take one value
else
    output=input(:,start_sample+argsLength+1);
end


end

