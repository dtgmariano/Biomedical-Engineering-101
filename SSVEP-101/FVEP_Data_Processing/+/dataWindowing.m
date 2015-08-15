function [ epoch_window_o1, epoch_window_o2, epoch_window_oz , epoch_window_pz] = dataWindowing(Ts, tgg, y_o1, y_o2, y_oz, y_pz)
%UNTITLED2 Summary of this function goes here

%Janelamento
twind = 0.3; %size of the window (seconds)
numAm = twind/Ts; %number of samples for twind
p1 = 0.0;
p2 = numAm;

epoch_window_o1 = 0;
epoch_window_o2 = 0;
epoch_window_oz = 0;
epoch_window_pz = 0;    

for i=1:size(tgg,2)
    d_o1 = detrend(y_o1((tgg(i)):(tgg(i)+p2)));
    d_o2 = detrend(y_o2((tgg(i)):(tgg(i)+p2)));
    d_oz = detrend(y_oz((tgg(i)):(tgg(i)+p2)));
    d_pz = detrend(y_pz((tgg(i)):(tgg(i)+p2)));

    epoch_window_o1 = epoch_window_o1 + d_o1;
    epoch_window_o2 = epoch_window_o2 + d_o2;
    epoch_window_oz = epoch_window_oz + d_oz;
    epoch_window_pz = epoch_window_pz + d_pz;
end

epoch_window_o1 = epoch_window_o1/size(tgg,2);
epoch_window_o2 = epoch_window_o2/size(tgg,2);
epoch_window_oz = epoch_window_oz/size(tgg,2);
epoch_window_pz = epoch_window_pz/size(tgg,2);


