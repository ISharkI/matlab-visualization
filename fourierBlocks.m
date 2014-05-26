function [  ] = fourierBlocks( input )
%UNTITLED Summary of this function goes here
%   divides the input signal into smaller blocks and derives a spectrum of
%   each blocks. draws the result
%   parameters: length of a block;number of figure
argsLength=input(1,1);
dim=size(input);
%y-Achse
xin=input(1,argsLength+2:end);
%x-Achse
yin=input(2,argsLength+2:end);

if argsLength<2
    error('parameter missing')
end
blockLength=input(1,2);
figure(input(1,3));
NFFT = 2^nextpow2(blockLength);
%how many Blocks can be created
numberOfBlocks=round((dim(2)-argsLength-1)/blockLength);

%preallocation
output=zeros(NFFT,numberOfBlocks);
yout=(1/(2*(xin(2)-xin(1)))) * linspace(-1,1,NFFT);
xout=linspace(min(xin),max(xin),numberOfBlocks);
for counter=1:numberOfBlocks
    z=fft(yin((blockLength*(counter-1)+1):blockLength*(counter-0.5)),NFFT);
    output(:,counter)=z;
    
end
surfc(xout,yout,abs(output))
xlabel('t(s)');
ylabel('f(Hz)');
end

