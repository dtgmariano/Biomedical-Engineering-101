function [ tggList ] = getTriggerPointsList( trigger )
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
tggList = tggList(1,2:size(tggList,2));
