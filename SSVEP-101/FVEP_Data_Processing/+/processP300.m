clear all;
clc;

%Filter Configurations
Fs = 240;
Ts = 1/Fs;

fc1low = 0.5;
fc1high = 30;
w1low = fc1low/(Fs/2);
w1high = fc1high/(Fs/2);
Wn1 = [w1low w1high];
n1 = 3;
[b1, a1] = butter(n1, Wn1,'bandpass');

fc2high = 20;
w2high = fc2high/(Fs/2);
Wn2 = w2high;
n2 = 5;
[b2, a2] = butter(n2, Wn2, 'low');

%p1_freq2 o1 e o2 ok
%Files configuration
path = 'C:\Users\Daniel\Dropbox\Data\';
files = ['p1_trial1_freq1.PLG';         %Patient 1, TrigFreq = 1Hz
         'p1_trial1_freq2.PLG';         %Patient 1, TrigFreq = 2Hz
         'p2_trial1_freq1.PLG';         %Patient 2, TrigFreq = 1Hz <-- Trigger error
         'p2_trial1_freq2.PLG';         %Patient 2, TrigFreq = 2Hz
         'p3_trial1_freq1.PLG';         %Patient 3, TrigFreq = 1Hz
         'p3_trial1_freq2.PLG';         %Patient 3, TrigFreq = 2Hz
         'p4_trial1_freq1.PLG';         %Patient 4, TrigFreq = 1Hz
         'p4_trial1_freq2.PLG';         %Patient 4, TrigFreq = 2Hz
         'p5_trial1_freq1.PLG';         %Patient 5, TrigFreq = 1Hz
         'p5_trial1_freq2.PLG';         %Patient 5, TrigFreq = 2Hz
         'p6_trial1_freq1.PLG';         %Patient 6, TrigFreq = 1Hz
         'p6_trial1_freq2.PLG';         %Patient 6, TrigFreq = 2Hz
         'p7_trial1_freq1.PLG';         %Patient 7, TrigFreq = 1Hz
         'p7_trial1_freq2.PLG';         %Patient 7, TrigFreq = 2Hz
         ];
fileIndex = 2;
fileName = files(fileIndex,:);
data = funcReadPLG(strcat(path,fileName));

%Data configuration
eegChannels = ['F7 ';'T3 ';'T5 ';'Fp1';'F3 ';
               'C3 ';'P3 ';'O1 ';'F8 ';'T4 ';
               'T6 ';'Fp2';'F4 ';'C4 ';'P4 ';
               'O2 ';'Fz ';'Cz ';'Pz ';'Oz ';
               'A1 ';'A2 ';'Tgg'];
channelsList = [8, 16, 20];
channel = channelsList(1);

%Channel 22 -> Observe the noise influence at the channel
au = data(22,:);

%Detecta os pontos de disparo do trigger
trigger = data(23,:);

flag = false;
j=1;

for i = 1:size(trigger,2)
    if (flag==false) && (trigger(i)<=0)
        flag = true;
        t(j) = i;
        j=j+1;
    end

    if (flag==true) && (trigger(i)==4)
        flag = false;
    end
end

t = t(1,2:size(t,2));

% z(1) = t(1);
% next = t(2)-t(1);
% 
% for i = 1:100
%     z(i) = t(1) + ((i-1)*next);
% end
% 
% for i= 2:100
%     A(i-1) = z(i)-z(i-1);
%     B(i-1) = t(i)-t(i-1);
% end

%Filtra o sinal original

% tgg = data(23,:);
% npoints = size(tgg,2);
% x = (1:npoints)*Ts;
% 
y_o1 = filtfilt(b1,a1,data(8,:));
y_o2 = filtfilt(b1,a1,data(16,:));
y_oz = filtfilt(b1,a1,data(20,:));
% % 
% % %Janelamento
twind = 0.3; %size of the window (seconds)
numAm = twind/Ts; %number of samples for twind
p1 = 0.0;
p2 = numAm;
% % 
epoch_window_o1 = 0;
epoch_window_o2 = 0;
epoch_window_oz = 0;
% % 
for i=1:size(z,2)
    epoch_window_o1 = epoch_window_o1 + detrend(y_o1((t(i)):(t(i)+p2)));
    epoch_window_o2 = epoch_window_o2 + detrend(y_o2((t(i)):(t(i)+p2)));
    epoch_window_oz = epoch_window_oz + detrend(y_oz((t(i)):(t(i)+p2)));
end

epoch_window_o1 = epoch_window_o1/(size(t,2)-1);
fepoch_window_o1 = filtfilt(b2,a2,epoch_window_o1);
epoch_window_o2 = epoch_window_o2/(size(t,2)-1);
fepoch_window_o2 = filtfilt(b2,a2,epoch_window_o2);
epoch_window_oz = epoch_window_oz/(size(t,2)-1);
fepoch_window_oz = filtfilt(b2,a2,epoch_window_oz);

wind_x = (1:size(epoch_window_o1,2))*Ts;

figure(1)
subplot(3,1,1)
plot(wind_x,epoch_window_o1);
legend(strcat(eegChannels(8,:),' '))
subplot(3,1,2)
plot(wind_x,epoch_window_o1);
legend(strcat(eegChannels(16,:),' '))
subplot(3,1,3)
plot(wind_x,epoch_window_oz);
legend(strcat(eegChannels(20,:),' '))

figure(2)
subplot(3,1,1)
plot(wind_x,fepoch_window_o1);
legend(strcat(eegChannels(8,:),' Filtered'))
subplot(3,1,2)
plot(wind_x,fepoch_window_o1);
legend(strcat(eegChannels(16,:),' Filtered'))
subplot(3,1,3)
plot(wind_x,fepoch_window_oz);
legend(strcat(eegChannels(20,:),' Filtered'))