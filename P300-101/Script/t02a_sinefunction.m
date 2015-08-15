% Program: Sine function with 2, 15 and 60 Hz
% Author: Alexandre Vieira Guerreiro
% Date: 17/11/2014

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

%%%%%%%%%%
%Plotting%
%%%%%%%%%%
figure(1)
subplot(4,1,1)
plot(t,y1)
subplot(4,1,2)
plot(t,y2)
subplot(4,1,3)
plot(t,y3)
subplot(4,1,4)
plot(t,y)



