clear;
clc;

%Filter Configurations
Fs = 240;
Ts = 1/Fs;
fc1 = 0.5;
fc2 = 30;
w1 = fc1/(Fs/2);
w2 = fc2/(Fs/2);
Wn = [w1 w2];
n = 5;
[b, a] = butter(n, Wn,'bandpass');

nPoints = 1000;
x = (1:nPoints)*Ts;

%Fsin freq(Hz)
f1h = 1;
f2h = 20;
f3h = 40;

fsin_1h = sin(2*pi*f1h*x);
fsin_2h = sin(2*pi*f2h*x);
fsin_3h = sin(2*pi*f3h*x);

fsin = fsin_1h + fsin_2h + fsin_3h;
fsin_filt = filter(b,a,fsin);

%FFT
l1 = size(fsin,2);
NFFT1 = 2^nextpow2(l1);
f1 = Fs/2*linspace(0,1,NFFT1/2+1);
Y1 = fft(fsin, NFFT1)/l1;

l2 = size(fsin_filt,2);
NFFT2 = 2^nextpow2(l2);
f2 = Fs/2*linspace(0,1,NFFT2/2+1);
Y2 = fft(fsin_filt, NFFT2)/l1;

%Graphs
figure(1)
subplot(5,1,1)
plot(x,fsin_1h);
subplot(5,1,2)
plot(x,fsin_2h);
subplot(5,1,3)
plot(x,fsin_3h);
subplot(5,1,4)
plot(x,fsin);
subplot(5,1,5)
plot(x,fsin_filt);

figure(2)
subplot(2,1,1)
plot(f1,2*abs(Y1(1:NFFT1/2+1)))
subplot(2,1,2)
plot(f2,2*abs(Y2(1:NFFT2/2+1)))