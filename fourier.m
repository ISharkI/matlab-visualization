function [ output ] = fourier( input )
%UNTITLED2 Summary of this function goes here
%   Applies fft or ifft on a given signal
argsLength=input(1,1);
if (argsLength>=1);
    type=1-input(1,2);
    dim=size(input);
    %y-Achse
    xin=input(1,argsLength+2:end);
    %x-Achse
    yin=input(2,argsLength+2:end);
    % NFFT that is a power of 2 increases performance
    NFFT = 2^nextpow2(dim(2)-argsLength-2);
    if (type==1)
        %do fft
        yout=fft(yin,NFFT);
        % x-axis from -0.5f_sample to +0.5f_sample
        xout=(1/(2*(xin(2)-xin(1)))) * linspace(-1,1,NFFT);
    elseif(type==0)
        %do ifft
        yout=ifft(yin,NFFT);
        %x-Axis stars from zero
        xout=(1/(1*(xin(2)-xin(1)))) * linspace(0,1,NFFT);
    else
        error('parameter out of range');
    end
    output=[xout;yout];
end

%



end

