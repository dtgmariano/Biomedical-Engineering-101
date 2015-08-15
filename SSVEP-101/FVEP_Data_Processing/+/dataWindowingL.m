function [ ew_o1, ew_o2, ew_oz , blinkPoints, epochPoints] = dataWindowingL(hasLimit, limitValue, Ts, tggList, y_o1, y_o2, y_oz, y_fp1, y_fp2 )
%Janelamento

twind = 0.3; %size of the window (seconds)
numAm = twind/Ts; %number of samples for twind
p1 = 0.0;
p2 = numAm;

epoch_window_o1 = 0;
epoch_window_o2 = 0;
epoch_window_oz = 0;
       
blinkPoints = 0;
epochPoints = 0;
c1 = 1;
c2 = 1;

%Algoritmo para realizar a média síncrona das épocas - t0: disparo do tgg - 
%eliminando as épocas onde ocorrem valores máximos (picos) em fp1 ou fp2 
if(hasLimit==true)
    for i=1:size(tggList,2)
        d_o1 = detrend(y_o1((tggList(i)):(tggList(i)+p2)));
        d_o2 = detrend(y_o2((tggList(i)):(tggList(i)+p2)));
        d_oz = detrend(y_oz((tggList(i)):(tggList(i)+p2)));
        d_fp1 = (y_fp1((tggList(i)):(tggList(i)+p2)));
        d_fp2 = (y_fp2((tggList(i)):(tggList(i)+p2)));

        if(max(d_fp1)>=limitValue || max(d_fp2)>=limitValue)
            blinkPoints(c1) = tggList(i);
            c1 = c1 + 1;
        else
            epochPoints(c2) = tggList(i);
            c2 = c2 + 1;
            epoch_window_o1 = epoch_window_o1 + d_o1;
            epoch_window_o2 = epoch_window_o2 + d_o2;
            epoch_window_oz = epoch_window_oz + d_oz;
        end  
    end
    epoch_window_o1 = epoch_window_o1/size(epochPoints,2);
    epoch_window_o2 = epoch_window_o2/size(epochPoints,2);
    epoch_window_oz = epoch_window_oz/size(epochPoints,2);
    
%Algoritmo para realizar a média síncrona de todas as épocas - t0: disparo do tgg
else
    for i=1:size(tggList,2)
        d_o1 = detrend(y_o1((tggList(i)):(tggList(i)+p2)));
        d_o2 = detrend(y_o2((tggList(i)):(tggList(i)+p2)));
        d_oz = detrend(y_oz((tggList(i)):(tggList(i)+p2)));
        epoch_window_o1 = epoch_window_o1 + d_o1;
        epoch_window_o2 = epoch_window_o2 + d_o2;
        epoch_window_oz = epoch_window_oz + d_oz;
    end
    epoch_window_o1 = epoch_window_o1/size(tggList,2);
    epoch_window_o2 = epoch_window_o2/size(tggList,2);
    epoch_window_oz = epoch_window_oz/size(tggList,2);
end



