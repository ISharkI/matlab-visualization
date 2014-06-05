function [ output ] = resampling( input )
%UNTITLED Summary of this function goes here
%   resamples the signal to the new sampling rate r_new=p/q*r_old
%   Parameters: p;q
argsLength=input(1,1);



%x-Achse
yin=input(1,argsLength+2:end);

if argsLength<3
    error('parameter missing')
end
%get the parameters
p=input(2);
q=input(3);
srin=input(4);
%resample

yout=resample(yin,p,q);
%create output
output=[srin*q/p yout];




end

