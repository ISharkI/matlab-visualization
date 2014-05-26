function [ output ] = resampling( input )
%UNTITLED Summary of this function goes here
%   resamples the signal to the new sampling rate r_new=p/q*r_old
%   Parameters: p;q
argsLength=input(1,1);

%y-Achse
xin=input(1,argsLength+2:end);
%x-Achse
yin=input(2,argsLength+2:end);

if argsLength<2
    error('parameter missing')
end
%get the parameters
p=input(1,2);
q=input(1,3);
%resample
xout=resample(xin,p,q);
yout=resample(yin,p,q);
%create output
output=[xout;yout];




end

