function [ output ] = fourierBlocks( input )
%UNTITLED Summary of this function goes here
%   divides the input signal into smaller blocks and derives a spectrum of
%   each blocks. returns the spectra one by one concatenated in a matrix
argsLength=input(1,1);
dim=size(input);
%y-Achse
xin=input(1,argsLength+2:end);
%x-Achse
yin=input(2,argsLength+2:end);

if argsLength<1
    error('parameter missing')
end
blockLength=input(1,2);
NFFT = 2^nextpow2(blockLength);
%how many Blocks can be created
numberOfBlocks=floor((dim(2)-argsLength)/blockLength);

%begin output by creating the frequency axis
x=(1/(2*(xin(2)-xin(1)))) * linspace(-1,1,NFFT);

for counter=1:numberOfBlocks
    y=fft(yin((blockLength*(counter-1)+1):blockLength*counter),NFFT);
    append=[x;y];
    % I admit this is ugly
    if ~exist('output','var')
        output=append;
    else
    output=[output append];
    end
end
end

