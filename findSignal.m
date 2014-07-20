function [ signal ] = findSignal( input )
%UNTITLED Summary of this function goes here
%   finds and returns the SIGNAL part of the first (2412kHz) band of an 802.11g WLAN sample
%   requires a signal that is already mixed down by 2,4GHz

%get parameters
args=input(1);
if (args<1)
    error('not enough arguments')
end
sr=input(2);
inpsig=input(args+3:end);
%length of the input signal is needed
[~,length]=size(inpsig);
figure(1);
plot(abs(fftshift(fft(inpsig))));
%mix the signal down with 12 kHZ
inpsig=inpsig.*exp(1i*2*pi*sr.*(1:length)*(-12000000));
figure(2);
plot(abs(fftshift(fft(inpsig))));
%apply lowpass filtering (this is only a workaround)
inpsig=resample(resample(inpsig,1,10),10,1);
figure(3);
plot(abs(fftshift(fft(inpsig))));
%load the standard training sequency in frequency and time domain
load('longt.mat');
load('longf.mat');
%resample the signal to 10^8 Samples per second
[p,q]=rat(sr*10^8)
inpsig = resample(inpsig,p,q);
%reshape the training sequence to 10^8 Samples per second
t_seq=reshape(longt,1,161);
t_seq=resample(t_seq,5,1);
%correlate signal with training sequence
[result,lags]=xcorr(inpsig,t_seq);
figure(4);
plot(abs(result));
%find maximum of correlation
pos = lags((abs(result)>=(max(abs(result))*1)))

%check the received long training sequence
rec_long1=fftshift(fft(resample(inpsig(pos(1)+160+1:pos(1)+160+320),1,5)));
rec_long2=fftshift(fft(resample(inpsig(pos(1)+160+320+1:pos(1)+160+320+320),1,5)));
%compare it to the standard
receivedLong=(0.5*(rec_long1+rec_long2));
figure(5);
plot(abs(((receivedLong))));
figure(6);
plot(abs(((longf))));
channelinv=diag(longf./receivedLong);

%find the signal field
sig = fftshift(fft(resample(inpsig(pos(1)+160+320+320+80+1:pos(1)+160+320+320+80+320),1,5)));
figure(7);
plot(abs(((sig))),'*');
%correct the signal field using the channel matrix
sig_korr = channelinv*sig';
figure(8);
plot((((sig_korr))),'*');


signal=ifft(fftshift(sig_korr))';
end

