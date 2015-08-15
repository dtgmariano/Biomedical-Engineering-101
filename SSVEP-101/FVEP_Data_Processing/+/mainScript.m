%Biomedical Engineering Laboratory
%Federal University of Uberlândia - MG/Brazil
%Author: Daniel Teodoro G Mariano
%Info: Script to process data collected eeg 

clear all
clc

%Data informations
Fs = 240;   %Sampling Frequency (kHz)
channelsList = [8, 16, 20];
eegChannels = ['F7 ';'T3 ';'T5 ';'Fp1';'F3 ';
               'C3 ';'P3 ';'O1 ';'F8 ';'T4 ';
               'T6 ';'Fp2';'F4 ';'C4 ';'P4 ';
               'O2 ';'Fz ';'Cz ';'Pz ';'Oz ';
               'A1 ';'A2 ';'Tgg'];

%File Info
path = 'Input\';
files = ['p1_trial1_freq1.PLG';         %Patient 1, TrigFreq = 1Hz
         'p1_trial1_freq2.PLG';         %Patient 1, TrigFreq = 2Hz
         'p2_trial1_freq1.PLG';         %Patient 2, TrigFreq = 1Hz
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
     
for k=1:14 
    
    fileIndex = k;
    fileName = files(fileIndex,:);
    data = funcReadPLG(strcat(path,fileName));

    %Butterworth Filter Parameters
    n = 5; 
    Wn = [1 90]/(Fs/2);
    [b,a] = butter(n,Wn);

    %Detects start and end of the trigger
    trigger = data(23,:);
    flag = false;
    for i = 1:size(trigger,2)
        if (flag==false) && (trigger(i)==4)
            flag = true;
            inicio = i;
        end

        if (flag==true) && (trigger(i)==0)
            flag = false;
            fim = i;
        end
    end

%for file 'p2_trial1_freq4.PLG' that has 4 trials in one file 
%trigger frequencies: 13, 17, 23, 29.9 Hz
%inicio = [2667,10405,17791,25171];
%fim = [7487,15225,22611,29991];

    for ch=1:3
        channel = channelsList(ch);

        signal = data(channel,:);
        x = 1:size(signal,2);
        cut_signal = signal(1, inicio: fim);
        xcut = 1:size(cut_signal,2);

        %FFT
        fsignal = filtfilt(b,a, cut_signal);
        length = size(fsignal,2);
        NFFT = 2^nextpow2(length);
        f = Fs/2*linspace(0,1,NFFT/2+1);
        Y = fft(fsignal, NFFT)/length;

        %Graphs
        screen_size = get(0, 'ScreenSize');
        f1 = figure(1);
        set(f1, 'Position', [0 0 screen_size(3) screen_size(4) ] );
        subplot(2,1,1)
        plot(x, (trigger/100),'r', x, signal, 'b')
        title(strcat(eegChannels(channel,:), ' Channel: entire signal', ' [Amplitude x Sample]'))
        subplot(2,1,2)
        plot(xcut, (trigger(1,inicio:fim)/100), 'r', xcut, cut_signal, 'b')
        title(strcat(eegChannels(channel,:), ' Channel: signal region where the trigger was activated', ' [Amplitude x Sample]'))
        %saveas(gcf,strcat('p',int2str(k),'_','channel_',int2str(ch),'_',eegChannels(channel,:),'_a.png'),'png')

        screen_size = get(0, 'ScreenSize');
        f2 = figure(2);
        set(f2, 'Position', [0 0 screen_size(3) screen_size(4) ] );
        subplot(2,1,1)
        plot(fsignal)
        title(strcat(eegChannels(channel,:), ' Channel: Filtered signal', '[Amplitude x Sample]'))
        subplot(2,1,2)
        plot(f,2*abs(Y(1:NFFT/2+1)))
        title('FFT')
        xlabel('Hz')
        %saveas(gcf,strcat('p',int2str(k),'_','channel_',int2str(ch),'_',eegChannels(channel,:),'_b.png'),'png')
    end
end