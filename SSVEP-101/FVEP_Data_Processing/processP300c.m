%Biomedical Engineering Laboratory
%Federal University of Uberlândia - MG/Brazil
%Author: Daniel Teodoro G Mariano
%Info: Script to process EEG data

clear all
clc

%Data configuration
eegChannels = ['F7 ';'T3 ';'T5 ';'Fp1';'F3 ';
               'C3 ';'P3 ';'O1 ';'F8 ';'T4 ';
               'T6 ';'Fp2';'F4 ';'C4 ';'P4 ';
               'O2 ';'Fz ';'Cz ';'Pz ';'Oz ';
               'A1 ';'A2 ';'Tgg'];
channelsList = [8, 16, 20];
    
%Filter Configurations
Fs = 240;
Ts = 1/Fs;

fc1low = 0.5;
fc1high = 30;
w1low = fc1low/(Fs/2);
w1high = fc1high/(Fs/2);
Wn1 = [w1low w1high];
n1 = 5;
[b1, a1] = butter(n1, Wn1,'bandpass');


threshold = [800, 1000, 2000, 1000, 500, 2000, 1000, 500, 2000, 2000, 1000, 800, 2000, 1000];
minIntervalP2 = [90, 100,100, 90, 70, 50,100,100,100,100, 80, 70,100,100];
maxIntervalP2 = [120,120,150,110,100,100,125,150,150,150,120,100,150,150];


for indexFile=1:14
    folderPath = 'C:\Users\Daniel\Dropbox\P300\Data\';
    filePath = getFilePath(indexFile);
    eegData = funcReadPLG(strcat(folderPath,filePath));

    %Detecta os pontos de disparo do trigger
    trigger = eegData(23,:);
    tggList = getTriggerPointsList(trigger);
    
    %Filtra o sinal original
    y_o1 = filtfilt(b1,a1,eegData(8,:));
    y_o2 = filtfilt(b1,a1,eegData(16,:));
    y_oz = filtfilt(b1,a1,eegData(20,:));
    y_fp1 = filtfilt(b1,a1,eegData(4,:));
    y_fp2 = filtfilt(b1,a1,eegData(12,:));
    
    %Janelamento
    thresholdValue = threshold(indexFile);
    %thresholdValue = 25;
    tWindow = 0.3;
    
    [ ew, blinkPoints, epochPoints ] = dataWindowingL2(thresholdValue, tWindow, Ts, tggList, y_o1, y_o2, y_oz, y_fp1, y_fp2);
    
    blinkCounter(indexFile) = size(blinkPoints,2);
    epochCounter(indexFile) = size(epochPoints,2);
    tggCounter(indexFile) = size(tggList,2);
    
    
    %Filtra o sinal resultante
    [ fsignals ] = filter2ndStage(ew, Fs);
    wind_x = (1:size(fsignals(1,:),2))*Ts*1000;
    
    lmin = round((90)/(1000*Ts));
    lmax = round((130)/(1000*Ts));
    
    %Encontra os valores e index de P2 em cada sinal
    [ vlr, idx ] = getP2(fsignals, lmin, lmax, Ts);
    
    %Escreve latências
    latFile = strcat('Out\',filePath(15:15),'Hz','_',filePath(1:2),'_P2latency.txt');
    f = fopen(latFile, 'w');
    fprintf(f,'%f\t%f\t%f\t%f\t%f\t%f\r\n', idx(1), idx(2), idx(3), idx(4), idx(5), idx(6));
    fclose(f);   

    %Gera gráficos
    outputFilePath = strcat('Out\',filePath(15:15),'Hz','_',filePath(1:2),'.bmp');
    hasSave = true;
    plotGraphs(vlr, idx, fsignals, wind_x, hasSave, outputFilePath)
    
end

counterFilePath = 'Out\counters.txt';
writeCounter(counterFilePath, tggCounter, blinkCounter, epochCounter);
