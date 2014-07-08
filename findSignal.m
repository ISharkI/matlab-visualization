function [ signal ] = findSignal( input )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
args=input(1);





inpsig=input(args+2:end);
load('longt.mat');
load('longf.mat');
inpsig = resample(inpsig,1,2);
t_seq=reshape(longt,1,161);
t_seq=resample(t_seq,5,1);
[result,lags]=xcorr(inpsig,t_seq);
figure(17);
plot(abs(result));
pos = lags(find(abs(result)>=(max(abs(result))*1)));
[l w]=size(pos)
for (i=1:w)
figure(20+i);
rec_long1=fftshift(fft(resample(inpsig(pos(i)+160+1:pos(i)+160+320),1,5)));
rec_long2=fftshift(fft(resample(inpsig(pos(i)+160+320+1:pos(i)+160+320+320),1,5)));
figure(1);
plot(abs(rec_long1),'*');
figure(2);
plot(abs(rec_long2),'*');
receivedLong=rec_long1;%(0.5*(rec_long1+rec_long2));
channelinv=diag(longf./receivedLong);
sig = fftshift(fft(resample(inpsig(pos(i)+160+320+320+80+1:pos(i)+160+320+320+80+320),1,5)));
figure(3);
plot(abs(sig),'*');

sig_korr = channelinv*sig';
figure(4);
plot(abs(sig_korr),'*');

figure(5);
plot(sig_korr,'*');

end
%figure(100);
%plot(fft(inpsig(pos(1)+161:pos(1)+161+63)),'*');
%figure(101);
%plot(linspace(1,64,64),imag(inpsig(pos(1)+161:pos(1)+161+63)));
signal=result;
end

