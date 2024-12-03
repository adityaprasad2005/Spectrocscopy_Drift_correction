%This file can be used to plot signal intensity vs Count for signal data "for simulated video.xlsx". For, e.g. one can see that we have 400 data points with an intensity of 10.

clc;
clear;
%signal variable is stored in .mat file 
signal=xlsread('for simulated video.xlsx','Sheet1');
signal=signal(:,2)';

%Intensity vs #samples plot
%In the original blinking it should be a Tri-Gaussian plot

%We need a counter 
signal_sort=sort(signal);
range_sig=signal_sort(end)-signal_sort(1);
lim_val=range_sig/10000;

intensityArr=double.empty;
countArr=double.empty;
temp=0;
count=0;
sum_int=0;
for i=signal_sort
    if abs(i-temp)<lim_val
        count=count+1;
        sum_int=sum_int+i;
    else
        countArr(end+1)=count;
        intensityArr(end+1)=sum_int/count;

        count=1;
        sum_int=i;
        temp=i;
    end
end

figure
area(intensityArr,countArr);

xlabel("Intensity");
ylabel("count")
title("Count Vs Intensity");
