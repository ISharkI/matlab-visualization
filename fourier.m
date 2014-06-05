function [ output  ] = fourier( input )
%UNTITLED2 Summary of this function goes here
%   Applies fft or ifft on a given signal
argsLength=input(1,1);
if (argsLength>=2);
    type=1-input(1,2);

    srin=input(1,3);
    
    yin=input(argsLength+2:end);
    % NFFT that is a power of 2 increases performance
    NFFT = 2^nextpow2(length(yin));
    if (type==1)
        %do fft
        yout=fft(yin,NFFT);
        
        % x-axis from -0.5f_sample to +0.5f_sample
        srout=(1/srin) ;
    elseif(type==0)
        %do ifft
        yout=ifft(yin,NFFT);
        %x-Axis stars from zero
        srout=(1/srin) ;
    else
        error('parameter out of range');
    end
    output=[srout yout];
end

%



end

