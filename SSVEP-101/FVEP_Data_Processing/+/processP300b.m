%Biomedical Engineering Laboratory
%Federal University of Uberlândia - MG/Brazil
%Author: Daniel Teodoro G Mariano
%Info: Script to process eeg data

clear all
clc

%Filter Configurations
Fs = 240;
Ts = 1/Fs;

fc1low = 0.5;
fc1high = 40;
w1low = fc1low/(Fs/2);
w1high = fc1high/(Fs/2);
Wn1 = [w1low w1high];
n1 = 5;
[b1, a1] = butter(n1, Wn1,'bandpass');

fc2high = 17;
w2high = fc2high/(Fs/2);
Wn2 = w2high;
n2 = 5;
[b2, a2] = butter(n2, Wn2, 'low');

%Files configuration
path = 'C:\Users\Biolab\Dropbox\Data\EEG_PEV_Coletas\';
files = [
%     'p1_trial1_freq1.PLG';         %P1, f = 1Hz
% %     'p2_trial1_freq1.PLG';         %P2, f = 1Hz <-- Trigger error
%     'p3_trial1_freq1.PLG';         %P3, f = 1Hz
%     'p4_trial1_freq1.PLG';         %P4, f = 1Hz
%     'p5_trial1_freq1.PLG';         %P5, f = 1Hz
%     'p6_trial1_freq1.PLG';         %P6, f = 1Hz
%     'p7_trial1_freq1.PLG';         %P7, f = 1Hz
%     'p8_trial1_freq1.PLG';         %P8, f = 1Hz 
    'p1_trial1_freq2.PLG';         %P1, f = 2Hz
    'p2_trial1_freq2.PLG';         %P2, f = 2Hz
    'p3_trial1_freq2.PLG';         %P3, f = 2Hz
    'p4_trial1_freq2.PLG';         %P4, f = 2Hz
    'p5_trial1_freq2.PLG';         %P5, f = 2Hz
    'p6_trial1_freq2.PLG';         %P6, f = 2Hz
    'p7_trial1_freq2.PLG';         %P7, f = 2Hz 
    'p8_trial1_freq2.PLG';         %P8, f = 2Hz 
    ];

for count=1:size(files,1)
%for count=1:2

    fileName = files(count,:);
    data = funcReadPLG(strcat(path,fileName));

    %Data configuration
    eegChannels = ['F7 ';'T3 ';'T5 ';'Fp1';'F3 ';
                   'C3 ';'P3 ';'O1 ';'F8 ';'T4 ';
                   'T6 ';'Fp2';'F4 ';'C4 ';'P4 ';
                   'O2 ';'Fz ';'Cz ';'Pz ';'Oz ';
                   'A1 ';'A2 ';'Tgg'];
    channelsList = [8, 16, 20];

    %Detecta os pontos de disparo do trigger
    trigger = data(23,:);
    
    t = getTriggerPointsList(trigger);
    
%     flag = false;
%     j=1;
%     for i = 1:size(trigger,2)
%         if (flag==false) && (trigger(i)<=0)
%             flag = true;
%             t(j) = i;
%             j=j+1;
%         end
% 
%         if (flag==true) && (trigger(i)==4)
%             flag = false;
%         end
%     end
%     t = t(1,2:size(t,2));
%     
%     size(t,2)
    
    y_fp1 = filtfilt(b1,a1,data(4,:));
    y_fp2 = filtfilt(b1,a1,data(12,:));

    %Filtra o sinal original
    y_o1 = filtfilt(b1,a1,data(8,:));
    y_o2 = filtfilt(b1,a1,data(16,:));
    y_oz = filtfilt(b1,a1,data(20,:));
    
%     figure(1)
%     subplot(3,1,1)
%     plot(y_fp2);
%     subplot(3,1,2)
%     plot(y_o2);
%     subplot(3,1,3)
%     plot(trigger);
%     varstr = input('etasd')
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
    epoch_window_fp1 = 0;
    epoch_window_fp2 = 0;
    
    % % 
    alarm = 0;
    point = 1;
    countBlinks = 0;
    countEpochs = 0;
    
    for i=1:size(t,2)
        
        d_o1 = detrend(y_o1((t(i)):(t(i)+p2)));
        d_o2 = detrend(y_o2((t(i)):(t(i)+p2)));
        d_oz = detrend(y_oz((t(i)):(t(i)+p2)));
        d_fp1 = (y_fp1((t(i)):(t(i)+p2)));
        d_fp2 = (y_fp2((t(i)):(t(i)+p2)));
        
        limit=200;
        
        if(max(d_fp1)>=limit || max(d_fp2)>=limit)
            alarm(point) = i;
            point = point + 1;
            countBlinks = countBlinks + 1;
        else
            countEpochs = countEpochs + 1;
            epoch_window_o1 = epoch_window_o1 + d_o1;
            epoch_window_o2 = epoch_window_o2 + d_o2;
            epoch_window_oz = epoch_window_oz + d_oz;
            wind_x = (1:size(epoch_window_o1,2))*Ts*1000;
        end
        
%         epoch_window_o1 = epoch_window_o1 + d_o1;
%         epoch_window_o2 = epoch_window_o2 + d_o2;
%         epoch_window_oz = epoch_window_oz + d_oz;
%         wind_x = (1:size(epoch_window_o1,2))*Ts*1000;
    end
    
%     epoch_window_o1 = epoch_window_o1/size(t,2);
%     epoch_window_o2 = epoch_window_o2/size(t,2);
%     epoch_window_oz = epoch_window_oz/size(t,2);
    countBlinks;
    countEpochs;
    
    epoch_window_o1 = epoch_window_o1/countEpochs;
    epoch_window_o2 = epoch_window_o2/countEpochs;
    epoch_window_oz = epoch_window_oz/countEpochs;

    fepoch_window_o1 = filtfilt(b2,a2,epoch_window_o1);
    fepoch_window_o2 = filtfilt(b2,a2,epoch_window_o2);
    fepoch_window_oz = filtfilt(b2,a2,epoch_window_oz);
    
    wind_x = (1:size(epoch_window_o1,2))*Ts*1000;

    screen_size = get(0, 'ScreenSize');
    f1 = figure(count);
    set(f1, 'Position', [0 0 screen_size(3) screen_size(4) ] );
    xmin = -10;
    xmax = 310;
    ymin = -60;
    ymax = 60;
    
%     subplot(3,2,1)
%     plot(wind_x,epoch_window_o1);
%     grid on
%     title(strcat(eegChannels(8,:),' '))
%     axis auto
% %     axis([xmin xmax ymin ymax])
%     
%     subplot(3,2,3)
%     plot(wind_x,epoch_window_o1);
%     grid on
%     title(strcat(eegChannels(16,:),' '))
%     axis auto
% %     axis([xmin xmax ymin ymax])
%         
%     subplot(3,2,5)
%     plot(wind_x,epoch_window_oz);
%     grid on
%     title(strcat(eegChannels(20,:),' '))
%     axis auto
% %     axis([xmin xmax ymin ymax])

    subplot(4,1,1)
    plot(wind_x,fepoch_window_o1);
    grid on
    title(strcat(eegChannels(8,:),' Filtered'))
    axis auto
    
    subplot(4,1,2)
    plot(wind_x,fepoch_window_o1);
    grid on
    title(strcat(eegChannels(16,:),' Filtered'))
    axis auto
    
    subplot(4,1,3)
    plot(wind_x,fepoch_window_oz);
    grid on
    title(strcat(eegChannels(20,:),' Filtered'))
    axis auto
    
    subplot(4,1,4)
    plot(trigger);
    
    outPath = strcat('Out\',files(count,1:2),'_',files(count,15:15),'Hz_lmt200.bmp');
    %saveas(gcf,outPath,'bmp')
end
