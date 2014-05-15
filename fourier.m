function [ output ] = fourier( input )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
argsLength=input(1);
if (argsLength>2);
    st=input(2);
    type=1-input(3);
    dim=size(input);
    if (type==1)
        input=2*input/(dim(2)-argsLength);
        st=1/(st*(dim(2)-argsLength));
    else
        input=input/2;
        st=1/(st*(dim(2)-argsLength));
    end
    output=[argsLength,st,type,input(4:argsLength),fft(input(argsLength+1:end),dim(2)-argsLength)];
end

%



end

