clear all
clc

%Butterworth Filter Parameters
n = 5; 
Wn = [1 90]/(200/2);
[b,a] = butter(n,Wn);

%Data informations
Fs = 240;   %Sampling Frequency (kHz)

%File Info
path = 'Collected_Data\';
files = 'p2_trial1_freq4.PLG';
     
fileIndex = 1;
fileName = files(fileIndex,:);

data = funcReadPLG(strcat(path,fileName));
trigger = data(23,:);

channelsList = [8, 16, 20]; %signal channels: o1, o2 and oz
channel = 22;
triggerIsOn = false;

j=1;

for i = 1:size(trigger,2)
   if (triggerIsOn==false) && (trigger(i)==4)
       triggerIsOn = true;
       points(j) = i;
       j = j+1;
   end
   if (triggerIsOn==true) && (trigger(i)==0)
       triggerIsOn = false;
       points(j) = i;
       j = j+1;
   end
end

signal = data(channel,:);
%x = 1:size(signal,2);

cs1 = signal(1, points(1): points(2));
cs2 = signal(1, points(3): points(4));
cs3 = signal(1, points(5): points(6));
cs4 = signal(1, points(7): points(8));

fs1 = filtfilt(b,a, cs1);
fs2 = filtfilt(b,a, cs2);
fs3 = filtfilt(b,a, cs3);
fs4 = filtfilt(b,a, cs4);

tg1 = trigger(1, points(1): points(2));
tg2 = trigger(1, points(3): points(4));
tg3 = trigger(1, points(5): points(6));
tg4 = trigger(1, points(7): points(8));

x1 = 1:size(cs1,2);

length1 = size(fs1,2);
NFFT1 = 2^nextpow2(length1);
f1 = Fs/2*linspace(0,1,NFFT1/2+1);
Y1 = fft(fs1, NFFT1)/length1;

length2 = size(fs2,2);
NFFT2 = 2^nextpow2(length2);
f2 = Fs/2*linspace(0,1,NFFT2/2+1);
Y2 = fft(fs2, NFFT2)/length2;

length3 = size(fs3,2);
NFFT3 = 2^nextpow2(length3);
f3 = Fs/2*linspace(0,1,NFFT3/2+1);
Y3 = fft(fs3, NFFT3)/length3;

length4 = size(fs4,2);
NFFT4 = 2^nextpow2(length4);
f4 = Fs/2*linspace(0,1,NFFT4/2+1);
Y4 = fft(fs4, NFFT4)/length4;

figure(1)
subplot(4,2,1)
plot(fs1)
subplot(4,2,2)
plot(f1,2*abs(Y1(1:NFFT1/2+1)))
subplot(4,2,3)
plot(fs2)
subplot(4,2,4)
plot(f2,2*abs(Y2(1:NFFT2/2+1)))
subplot(4,2,5)
plot(fs3)
subplot(4,2,6)
plot(f3,2*abs(Y3(1:NFFT3/2+1)))
subplot(4,2,7)
plot(fs4)
subplot(4,2,8)
plot(f4,2*abs(Y4(1:NFFT4/2+1)))

