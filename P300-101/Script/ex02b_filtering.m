% Program: Filter Example
% Author: Daniel T. G. Mariano
% Date: 10/11/2014

clear all;
clc;

%%%%%%%%%%%%%%%%%%%%
%Sampling Frequency%
%%%%%%%%%%%%%%%%%%%%
Fs = 240;                               %Sampling frequency
Ts = 1/Fs;                              %Period
ws = 2*pi*60;


%%%%%%%%%%%%%%%
%Main Function%
%%%%%%%%%%%%%%%
t = 0: Ts: 2;                           %time axis

fy1 = 10;                               %1st Harmonic Frequency
fy2 = 60;                               %2nd Harmonic Frequency

y1 = sin(t*(fy1*ws)/(Fs/2));            %Component 1 of Main Function
y2 = sin(t*(fy2*ws)/(Fs/2));            %Component 2 of Main Function
y = y1 + y2;                            %Main Function


%%%%%%%%%%%%%%%%%%%%%%%
%Filter configurations%
%%%%%%%%%%%%%%%%%%%%%%%
fc1low = 0.5;                           %Low frequency cut
fc1high = 20;                           %High frequency cut
w1low = fc1low/(Fs/2);                  %Adjusted low frequency cut          
w1high = fc1high/(Fs/2);                %Adjusted high frequency cut
Wn1 = [w1low w1high];
n1 = 5;                                 %Filter Order
[b1, a1] = butter(n1, Wn1,'bandpass');  %Bandpass filter


%%%%%%%%%%%%%%%%%%%
%Filtered Function%
%%%%%%%%%%%%%%%%%%%
yf = filtfilt(b1,a1,y);

%%%%%%%%%%
%Plotting%
%%%%%%%%%%
figure(1)
subplot(4,1,1)
plot(t,y1)
subplot(4,1,2)
plot(t,y2)
subplot(4,1,3)
plot(t,y)
subplot(4,1,4)
plot(t,yf)