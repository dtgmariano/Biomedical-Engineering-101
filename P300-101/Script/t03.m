% Program: Task 03
% Author: Alexandre Vieira Guerreiro
% Date: 28/11/2014

%eegChannels = ['F7 ';'T3 ';'T5 ';'Fp1';'F3 ';
%               'C3 ';'P3 ';'O1 ';'F8 ';'T4 ';
%               'T6 ';'Fp2';'F4 ';'C4 ';'P4 ';
%               'O2 ';'Fz ';'Cz ';'Pz ';'Oz ';
%               'A1 ';'A2 ';'Tgg'];

List = [6,23];

clear all;
clc;

filePath = strcat(pwd,'\Data\p1_trial1_freq1.PLG');
eegData = funcReadPLG(filePath);

c3 = eegData(6,:);
trigger = eegData(23,:);

%%%%%%%%%%%%%%%%%%%%
%Sampling Frequency%
%%%%%%%%%%%%%%%%%%%%
Fs = 240;                               %Sampling frequency
Ts = 1/Fs;                              %Period
ws = 2*pi*60;

%%%%%%%%%%%%%%%%%%%%%%%
%Filter configurations%
%%%%%%%%%%%%%%%%%%%%%%%
fc1low = 0.5;                           %Low frequency cut
fc1high = 30;                           %High frequency cut
w1low = fc1low/(Fs/2);                  %Adjusted low frequency cut          
w1high = fc1high/(Fs/2);                %Adjusted high frequency cut
Wn1 = [w1low w1high];
n1 = 5;                                 %Filter Order
[b1, a1] = butter(n1, Wn1,'bandpass');  %Bandpass filter

%%%%%%%%%%%%%%%%%%%
%Filtered Sinal%
%%%%%%%%%%%%%%%%%%%
c3f = filtfilt(b1,a1,c3);

%%%%%%%%%%
%Plotting%
%%%%%%%%%%
figure(1)
subplot(3,1,1)
plot(c3)
subplot(3,1,2)
plot(c3f)
subplot(3,1,3)
plot(trigger)


indices = find((trigger)==0);
c3f(indices) = [];
trigger(indices) = [];

%%%%%%%%%%
%Plotting%
%%%%%%%%%%
figure(2)
subplot(2,1,1)
plot(c3f)
subplot(2,1,2)
plot(trigger)





