function [ fsignals ] = firstFilter(selectedEEGChannels, eegData, Fs)

fc1low = 0.5;
fc1high = 30;

w1low = fc1low/(Fs/2);
w1high = fc1high/(Fs/2);

Wn1 = [w1low w1high];
n1 = 5;

[b1, a1] = butter(n1, Wn1,'bandpass');

fsignals = 0;

for i=1:size(selectedEEGChannels,1)
    fsignals(i) = filtfilt(b1,a1,eegData(selectedEEGChannels(i),:));
end

