% Program: Filtering 2 e 15 Hz
% Author: Alexandre Vieira Guerreiro
% Date: 20/11/2014

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

fy1 = 2;                               %1st Harmonic Frequency
fy2 = 15;                              %2nd Harmonic Frequency
fy3 = 60;                              %3nd Harmonic Frequency

y1 = sin(t*(fy1*ws)/(Fs/2));            %Component 1 of Main Function
y2 = sin(t*(fy2*ws)/(Fs/2));            %Component 2 of Main Function
y3 = sin(t*(fy3*ws)/(Fs/2));            %Component 3 of Main Function
y = y1 + y2 + y3;                       %Main Function


%%%%%%%%%%%%%%%%%%%%%%%
%Filter configurations%
%%%%%%%%%%%%%%%%%%%%%%%
fc1low = 2;                             %Low frequency cut
fc1high = 15;                           %High frequency cut
w1low = fc1low/(Fs/2);                  %Adjusted low frequency cut          
w1high = fc1high/(Fs/2);                %Adjusted high frequency cut
Wn1 = [w1low w1high];
n1 = 5;                                 %Filter Order
[b1, a1] = butter(n1, Wn1,'bandpass');  %Bandpass filter


%%%%%%%%%%%%%%%%%%%
%Filtered Function%
%%%%%%%%%%%%%%%%%%%
y_filt2 = filtfilt(b1,a1,y);

%%%%%%%%%%
%Plotting%
%%%%%%%%%%
figure(1)
subplot(5,1,1)
plot(t,y1)
subplot(5,1,2)
plot(t,y2)
subplot(5,1,3)
plot(t,y3)
subplot(5,1,4)
plot(t,y)
subplot(5,1,5)
plot(t,y_filt2)