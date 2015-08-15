function [ epoch_window_o1, epoch_window_o2, epoch_window_oz ,epoch_window_cz, blinkPoints, epochPoints] = dataWindowingLimiting(limitValue, Ts, tgg, y_o1, y_o2, y_oz, y_cz, y_fp1, y_fp2 )
%UNTITLED2 Summary of this function goes here

%Janelamento
twind = 0.3; %size of the window (seconds)
numAm = twind/Ts; %number of samples for twind
p1 = 0.0;
p2 = numAm;

epoch_window_o1 = 0;
epoch_window_o2 = 0;
epoch_window_oz = 0;
epoch_window_cz = 0;
       
blinkPoints = 0;
epochPoints = 0;
c1 = 1;
c2 = 1;

for i=1:size(tgg,2)
    d_o1 = detrend(y_o1((tgg(i)):(tgg(i)+p2)));
    d_o2 = detrend(y_o2((tgg(i)):(tgg(i)+p2)));
    d_oz = detrend(y_oz((tgg(i)):(tgg(i)+p2)));
    d_cz = detrend(y_cz((tgg(i)):(tgg(i)+p2)));
    
    d_fp1 = (y_fp1((tgg(i)):(tgg(i)+p2)));
    d_fp2 = (y_fp2((tgg(i)):(tgg(i)+p2)));
    
    if(max(d_fp1)>=limitValue || max(d_fp2)>=limitValue)
        blinkPoints(c1) = tgg(i);
        c1 = c1 + 1;
    else
        epochPoints(c2) = tgg(i);
        c2 = c2 + 1;
        
        epoch_window_o1 = epoch_window_o1 + d_o1;
        epoch_window_o2 = epoch_window_o2 + d_o2;
        epoch_window_oz = epoch_window_oz + d_oz;
        epoch_window_cz = epoch_window_cz + d_cz;
    end  
end

epoch_window_o1 = epoch_window_o1/size(epochPoints,2);
epoch_window_o2 = epoch_window_o2/size(epochPoints,2);
epoch_window_oz = epoch_window_oz/size(epochPoints,2);
epoch_window_cz = epoch_window_cz/size(epochPoints,2);


