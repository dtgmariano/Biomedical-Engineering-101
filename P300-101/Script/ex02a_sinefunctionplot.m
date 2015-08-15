% Program: Plotting sine function
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


%%%%%%%%%%
%Plotting%
%%%%%%%%%%
figure(1)
subplot(3,1,1)
plot(t,y1)
subplot(3,1,2)
plot(t,y2)
subplot(3,1,3)
plot(t,y)