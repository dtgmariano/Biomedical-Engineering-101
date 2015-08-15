function [ filePath ] = getFilePath( index )

%Files configuration
files = [
    'p1_trial1_freq1.PLG';              %P1, f = 1Hz 50 disparos
    'p3_trial1_freq1.PLG';              %P3, f = 1Hz 50 disparos
    'p4_trial1_freq1.PLG';              %P4, f = 1Hz 50 disparos
    'p5_trial1_freq1.PLG';              %P5, f = 1Hz 50 disparos
    'p6_trial1_freq1.PLG';              %P6, f = 1Hz 50 disparos
    'p7_trial1_freq1.PLG';              %P7, f = 1Hz 50 disparos
    'p8_trial1_freq1.PLG';              %P8, f = 1Hz 50 disparos
    
    'p1_trial1_freq2.PLG';              %P1, f = 2Hz 100 disparos  
    'p3_trial1_freq2.PLG';              %P3, f = 2Hz 50 disparos
    'p4_trial1_freq2.PLG';              %P4, f = 2Hz 100 disparos
    'p5_trial1_freq2.PLG';              %P5, f = 2Hz 100 disparos
    'p6_trial1_freq2.PLG';              %P6, f = 2Hz 100 disparos
    'p7_trial1_freq2.PLG';              %P7, f = 2Hz 100 disparos
    'p8_trial1_freq2.PLG';              %P8, f = 2Hz 100 disparos
];

filePath = files(index,:);
end

