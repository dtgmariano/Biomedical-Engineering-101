function plotGraphs(vlr, idx, few, wind_x, hasSave, outputFilePath)
    
titles = ['O1_a, Latência de P_2: ';
          'O2_a, Latência de P_2: ';
          'Oz_a, Latência de P_2: ';
          'O1_b, Latência de P_2: ';
          'O2_b, Latência de P_2: ';
          'Oz_b, Latência de P_2: '];
         
screen_size = get(0, 'ScreenSize');
f1 = figure();
set(f1, 'Position', [0 0 screen_size(3) screen_size(4) ] );
 
for i=1:2
    subplot(1,2,i)
    plot(wind_x,few(i,:));
    hold on
    scatter(idx(i), vlr(i),'r*');
    grid on
    title(strcat(titles(i,:),num2str(idx(i)),' ms'))
    axis auto
    
end
    
if(hasSave == true)
    saveas(f1,outputFilePath,'bmp')
end


