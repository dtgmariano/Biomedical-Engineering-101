function writeCounter(counterFilePath, tggCounter, blinkCounter, epochCounter )

f = fopen(counterFilePath, 'w');
fprintf(f, 'tggCounter\tblinkCounter\tepochCounter\r\n');
for i=1:size(blinkCounter,2)
    fprintf(f, '%f\t%f\t%f\r\n', tggCounter(i), blinkCounter(i), epochCounter(i));
end
fclose(f);


