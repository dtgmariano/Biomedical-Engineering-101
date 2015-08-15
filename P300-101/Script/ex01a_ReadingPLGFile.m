%eegChannels = ['F7 ';'T3 ';'T5 ';'Fp1';'F3 ';
%               'C3 ';'P3 ';'O1 ';'F8 ';'T4 ';
%               'T6 ';'Fp2';'F4 ';'C4 ';'P4 ';
%               'O2 ';'Fz ';'Cz ';'Pz ';'Oz ';
%               'A1 ';'A2 ';'Tgg'];

%06/11/2014

List = [8,16,20,23];


clear all
clc

filePath = strcat(pwd,'\Data\p1_trial1_freq1.PLG'); %pwd => currentFolder

eegData = funcReadPLG(filePath);

o1 = eegData(8,:);
o2 = eegData(16,:);
trigger = eegData(23,:);
indices = find((trigger)==0);
o1(indices) = [];
o2(indices) = [];
trigger(indices) = [];

figure(1)
subplot(3,1,1)
plot(o1);
subplot(3,1,2)
plot(o2);
subplot(3,1,3)
plot(trigger);