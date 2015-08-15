clear all;
clc;

%Filter Configurations
Fs = 240;
Ts = 1/Fs;
fc1 = 0.5;
fc2 = 30;
w1 = fc1/(Fs/2);
w2 = fc2/(Fs/2);
Wn = [w1 w2];
n = 3;
[b, a] = butter(n, Wn,'bandpass');

fc2high = 20;
w2high = fc2high/(Fs/2);
Wn2 = w2high;
n = 5;
[b2, a2] = butter(n, Wn2, 'low');

%p1_freq2 o1 e o2 ok
%Files configuration
path = 'Input\';
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
fileIndex = 8;
fileName = files(fileIndex,:);
data = funcReadPLG(strcat(path,fileName));

%Data configuration
eegChannels = ['F7 ';'T3 ';'T5 ';'Fp1';'F3 ';
               'C3 ';'P3 ';'O1 ';'F8 ';'T4 ';
               'T6 ';'Fp2';'F4 ';'C4 ';'P4 ';
               'O2 ';'Fz ';'Cz ';'Pz ';'Oz ';
               'A1 ';'A2 ';'Tgg'];
channelsList = [8, 16, 20];
channel = channelsList(2);

%Channel 22 -> Observe the noise influence at the channel
au = data(22,:);

%Detecta os pontos de disparo do trigger
trigger = data(23,:);

flag = false;
j=1;
for i = 1:size(trigger,2)
    if (flag==false) && (trigger(i)<=0)
        flag = true;
        tggList(j) = i;
        j=j+1;
    end

    if (flag==true) && (trigger(i)==4)
        flag = false;
    end
end

%Filtra o sinal original
signal = data(channel,:);
npoints = size(signal,2);
x = (1:npoints)*Ts;
y = filtfilt(b,a,signal);

        
%Janelamento
twind = 0.3; %size of the window (seconds)
numAm = twind/Ts; %number of samples for twind

p1 = 0.0;
p2 = numAm;
window_sum = 0;

for i=2:size(tggList,2)
    tn = i;
    %window_x = ((tggList(tn)-p1):(tggList(tn)+p2))*Ts;
    %window_sig = signal((tggList(tn)-p1):(tggList(tn)+p2));
    window_fsig = detrend(y((tggList(tn)-p1):(tggList(tn)+p2)));
    %window_tgg = trigger((tggList(tn)-p1):(tggList(tn)+p2));
    %window_detrend = detrend(window_fsig);
    %trend = window_fsig - window_detrend;
    window_sum = window_sum + window_fsig;
end

window_sum = window_sum/(size(tggList,2)-1);
filter_window_sum = filtfilt(b2, a2, window_sum);
wind_x = (1:size(window_sum,2))*Ts;
figure(1)
subplot(2,1,1)
plot(wind_x,window_sum);
subplot(2,1,2)
plot(wind_x,filter_window_sum);
legend(strcat(eegChannels(channel,:),' Filtered'))

% tn = 2; %Trigger index at the trigger list
% window_x = ((tggList(tn)-p1):(tggList(tn)+p2))*Ts;
% window_sig = signal((tggList(tn)-p1):(tggList(tn)+p2));
% window_fsig = y((tggList(tn)-p1):(tggList(tn)+p2));
% window_tgg = trigger((tggList(tn)-p1):(tggList(tn)+p2));
% window_detrend = detrend(window_fsig);
% trend = window_fsig - window_detrend;

dx100 = 0.1/Ts;
point(1) = dx100 + p1;
point(2) = 2*dx100 + p1;
point(3) = 3*dx100 + p1;



%FFT
%l1 = size(window_sig,2);
%NFFT1 = 2^nextpow2(l1);
%f1 = Fs/2*linspace(0,1,NFFT1/2+1);
%Y1 = fft(window_sig, NFFT1)/l1;

%l2 = size(window_fsig,2);
%NFFT2 = 2^nextpow2(l2);
%f2 = Fs/2*linspace(0,1,NFFT2/2+1);
%Y2 = fft(window_fsig, NFFT2)/l1;


%figure(1)
%subplot(4,1,1)
%plot(x,signal,'b')
%legend(strcat(eegChannels(channel,:)))
%subplot(4,1,2)
%plot(x,y)
%legend(strcat(eegChannels(channel,:),' Filtered'))
%subplot(4,1,3)
%plot(x,trigger,'r')
%legend('Trigger')
%subplot(4,1,4)
%plot(x,au,'r')
%legend('Auricular Signal')
% 
% figure(2)
% subplot(3,1,1)
% plot(window_x,window_sig,'r',window_x,window_detrend,'b');
% legend('Original Data', 'Detrended Data')
% 
% subplot(3,1,2)
% plot(window_x,window_detrend,'b');
% hold on
% scatter(window_x(point),window_detrend(point),'r');
% legend('Detrended Data')
% 
% subplot(3,1,3)
% plot(window_x,window_tgg,'g');
% legend('Trigger')

%figure(3)
%subplot(2,1,1)
%plot(f1,2*abs(Y1(1:NFFT1/2+1)),'r')
%legend('Signal Window')
%subplot(2,1,2)
%plot(f2,2*abs(Y2(1:NFFT2/2+1)),'b')
%legend('Filtered Signal Window')
