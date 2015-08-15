function [ fsignals ] = filter2ndStage(ew, Fs)

fc2high = 30;
w2high = fc2high/(Fs/2);

Wn2 = w2high;

n2 = 5;
[b2, a2] = butter(n2, Wn2, 'low');

few1 = filtfilt(b2,a2,ew(1,:));
few2 = filtfilt(b2,a2,ew(2,:));
few3 = filtfilt(b2,a2,ew(3,:));
few4 = filtfilt(b2,a2,ew(4,:));
few5 = filtfilt(b2,a2,ew(5,:));
few6 = filtfilt(b2,a2,ew(6,:));

fsignals = [few1; few2; few3; few4; few5; few6];



