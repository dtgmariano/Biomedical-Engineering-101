clear all
clc

%Butterworth Filter Parameters
n = 5; 
Wn = [1 90]/(200/2);
[b,a] = butter(n,Wn);

%Data informations
Fs = 120;   %Sampling Frequency (kHz)

%File Info
path = 'Collected_Data\';
files = ['p1_trial1_freq1.PLG';
            'p1_trial1_freq2.PLG';
            'p1_trial1_freq3.PLG';
            'p2_trial1_freq1.PLG';
            'p2_trial1_freq2.PLG';
            'p2_trial1_freq3.PLG';
            'p3_trial1_freq1.PLG';
            'p3_trial1_freq2.PLG';
            'p3_trial1_freq3.PLG'];

%for j=1:size(fileName,1)
fileIndex = 2;
fileName = files(fileIndex,:);
data = funcReadPLG(strcat(path,fileName));
channels = [6, 12, 20]; %signal channels: o1, o2 and oz
trigger = data(23,:);

%%
%for i=1:size(channels,2)
%i = 1;
%idx = channels(i);
canal = 6;
signal = data(canal,:);
fsignal = filtfilt(b,a, signal);
length = size(signal,2);
NFFT = 2^nextpow2(length);
f = Fs/2*linspace(0,1,NFFT/2+1);
Y = fft(fsignal, NFFT)/length;

figure(1)
subplot(4,1,1)
plot(trigger)
subplot(4,1,2)
plot(signal)
subplot(4,1,3)
plot(fsignal) 
subplot(4,1,4)
plot(f,2*abs(Y(1:NFFT/2+1)))         
%end
%end

%%


