clear all
clc

Fs = 120; %Sampling Frequency (kHz)

path = 'Collected_Data\';
fileName = ['p1_trial1_freq1.PLG'; 'p1_trial1_freq2.PLG'; 'p1_trial1_freq3.PLG'];

data11 = funcReadPLG(strcat(path,fileName(1,:)));
data12 = funcReadPLG(strcat(path,fileName(2,:)));
data13 = funcReadPLG(strcat(path,fileName(3,:)));

%Butterworth Filter Parameters
n = 5; 
Wn = [1 90]/(200/2);
[b,a] = butter(n,Wn);

s11_o1 = data11(8,:);
s11_o2 = data11(16,:);
s11_oz = data11(20,:);
s11_tg = data11(23,:);

s12_o1 = data12(8,:);
s12_o2 = data12(16,:);
s12_oz = data12(20,:);
s12_tg = data12(23,:);

s13_o1 = data13(8,:);
s13_o2 = data13(16,:);
s13_oz = data13(20,:);
s13_tg = data13(23,:);

figure(1)
subplot(4,1,1)
plot(s11_o1)    %Channel  8: O1
subplot(4,1,2)
plot(s11_o2)    %Channel 16: O2
subplot(4,1,3)
plot(s11_oz)    %Channel 20: Oz
subplot(4,1,4)
plot(s11_tg)    %Channel 23: Trigger

s11_o1 = filtfilt(b,a,data11(8,:));
s11_o2 = filtfilt(b,a,data11(16,:));
s11_oz = filtfilt(b,a,data11(20,:));

s12_o1 = filtfilt(b,a,data12(8,:));
s12_o2 = filtfilt(b,a,data12(16,:));
s12_oz = filtfilt(b,a,data12(20,:));

s13_o1 = filtfilt(b,a,data13(8,:));
s13_o2 = filtfilt(b,a,data13(16,:));
s13_oz = filtfilt(b,a,data13(20,:));

%Channel   8: O1
%Channel  16: O2
%Channel  20: Oz
%Channel  23: Trigger

%for i=1:23
%    y1(i,:) = filtfilt(b,a,data11(i,:));
%    y2(i,:) = filtfilt(b,a,data12(i,:));
%    y3(i,:) = filtfilt(b,a,data13(i,:));
%end

figure(2)
subplot(4,1,1)
plot(s11_o1)    %Channel  8: O1
subplot(4,1,2)
plot(s11_o2)    %Channel 16: O2
subplot(4,1,3)
plot(s11_oz)    %Channel 20: Oz
subplot(4,1,4)
plot(s11_tg)    %Channel 23: Trigger

figure(3)
subplot(4,1,1)
plot(s12_o1)    %Channel  8: O1
subplot(4,1,2)
plot(s12_o2)    %Channel 16: O2
subplot(4,1,3)
plot(s12_oz)    %Channel 20: Oz
subplot(4,1,4)
plot(s12_tg)    %Channel 23: Trigger

figure(4)
subplot(4,1,1)
plot(s13_o1)    %Channel  8: O1
subplot(4,1,2)
plot(s13_o2)    %Channel 16: O2
subplot(4,1,3)
plot(s13_oz)    %Channel 20: Oz
subplot(4,1,4)
plot(s13_tg)    %Channel 23: Trigger

L11_o1 = size(s11_o1);
NFFT11_o1 = 2^nextpow2(L11_o1(2)); % Next power of 2 from length of y
f11_o1 = Fs/2*linspace(0,1,NFFT11_o1/2+1);
Y11_o1 = fft(s11_o1, NFFT11_o1)/L11_o1(2);

L11_o2 = size(s11_o2);
NFFT11_o2 = 2^nextpow2(L11_o2(2)); % Next power of 2 from length of y
f11_o2 = Fs/2*linspace(0,1,NFFT11_o2/2+1);
Y11_o2 = fft(s11_o2, NFFT11_o2)/L11_o2(2);

L11_oz = size(s11_oz);
NFFT11_oz = 2^nextpow2(L11_oz(2)); % Next power of 2 from length of y
f11_oz = Fs/2*linspace(0,1,NFFT11_oz/2+1);
Y11_oz = fft(s11_oz, NFFT11_oz)/L11_oz(2);



L12_o1 = size(s12_o1);
NFFT12_o1 = 2^nextpow2(L12_o1(2)); % Next power of 2 from length of y
f12_o1 = Fs/2*linspace(0,1,NFFT12_o1/2+1);
Y12_o1 = fft(s12_o1, NFFT12_o1)/L12_o1(2);

L12_o2 = size(s12_o2);
NFFT12_o2 = 2^nextpow2(L12_o2(2)); % Next power of 2 from length of y
f12_o2 = Fs/2*linspace(0,1,NFFT12_o2/2+1);
Y12_o2 = fft(s11_o2, NFFT12_o2)/L12_o2(2);

L12_oz = size(s12_oz);
NFFT12_oz = 2^nextpow2(L12_oz(2)); % Next power of 2 from length of y
f12_oz = Fs/2*linspace(0,1,NFFT12_oz/2+1);
Y12_oz = fft(s12_oz, NFFT12_oz)/L12_oz(2);



L13_o1 = size(s13_o1);
NFFT13_o1 = 2^nextpow2(L13_o1(2)); % Next power of 2 from length of y
f13_o1 = Fs/2*linspace(0,1,NFFT13_o1/2+1);
Y13_o1 = fft(s13_o1, NFFT13_o1)/L13_o1(2);

L13_o2 = size(s13_o2);
NFFT13_o2 = 2^nextpow2(L13_o2(2)); % Next power of 2 from length of y
f13_o2 = Fs/2*linspace(0,1,NFFT13_o2/2+1);
Y13_o2 = fft(s13_o2, NFFT13_o2)/L13_o2(2);

L13_oz = size(s13_oz);
NFFT13_oz = 2^nextpow2(L13_oz(2)); % Next power of 2 from length of y
f13_oz = Fs/2*linspace(0,1,NFFT13_oz/2+1);
Y13_oz = fft(s13_oz, NFFT13_oz)/L13_oz(2);



figure(5)
subplot(3,1,1)
plot(f11_o1,2*abs(Y11_o1(1:NFFT11_o1/2+1))) 
subplot(3,1,2)
plot(f11_o2,2*abs(Y11_o2(1:NFFT11_o2/2+1))) 
subplot(3,1,3)
plot(f11_oz,2*abs(Y11_oz(1:NFFT11_oz/2+1))) 

figure(6)
subplot(3,1,1)
plot(f12_o1,2*abs(Y12_o1(1:NFFT12_o1/2+1))) 
subplot(3,1,2)
plot(f12_o2,2*abs(Y12_o2(1:NFFT12_o2/2+1))) 
subplot(3,1,3)
plot(f12_oz,2*abs(Y12_oz(1:NFFT12_oz/2+1))) 

figure(7)
subplot(3,1,1)
plot(f13_o1,2*abs(Y13_o1(1:NFFT13_o1/2+1))) 
subplot(3,1,2)
plot(f13_o2,2*abs(Y13_o2(1:NFFT13_o2/2+1))) 
subplot(3,1,3)
plot(f13_oz,2*abs(Y13_oz(1:NFFT13_oz/2+1))) 


