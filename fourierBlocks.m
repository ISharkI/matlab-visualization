function [ output ] = fourierBlocks( input )
%UNTITLED Summary of this function goes here
%   divides the input signal into smaller blocks and derives a spectrum of
%   each blocks. draws the result
%   parameters: length of a block;number of figure
argsLength=input(1,1);
dim=size(input);

yin=input(argsLength+2:end);

if argsLength<3
    error('parameter missing')
end
blockLength=input(1,2);
figure(input(1,3));

srin=input(1,4);
%how many Blocks can be created
numberOfBlocks=round((dim(2)-argsLength-1)/blockLength);
NFFT = 2^nextpow2(numberOfBlocks);
%preallocation
output=zeros(NFFT,numberOfBlocks);
yout=(1/(2*srin)) * linspace(-1,1,NFFT);
xout=linspace(0,(dim(2)-argsLength-1)*srin,numberOfBlocks);
for counter=1:numberOfBlocks
    z=fft(yin((blockLength*(counter-1)+1):blockLength*(counter-0.5)),NFFT);
    output(:,counter)=z;
    
end
output=figure;
surfc(xout,yout,abs(output))
zlabel('amplitude');
xlabel('t(s)');
ylabel('f(Hz)');
end

