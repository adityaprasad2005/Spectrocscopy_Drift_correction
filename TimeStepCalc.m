%This file plots TimeStepSize vs signal intensity. For, e.g. one can see that signals with an intensity of 100 have the longest residual time. It also plots the above graph for HIGH LOW and MEDIUM signals separately.

clc;
clear;
signal=xlsread('for simulated video.xlsx','Sheet1');
signal=signal(:,2)';

signal_sort=sort(signal);
range_sig=signal_sort(end)-signal_sort(1);
lim_val=range_sig/3;
intensityArr=double.empty;
TimeArr=double.empty;
temp=0;
count=0;
sum_int=0;
for i=signal   %Here is the diff from Plots.m code
    if abs(i-temp)<lim_val
        count=count+1;
        sum_int=sum_int+i;
    else
        TimeArr(end+1)=count;
        int_val=sum_int/count;
        intensityArr(end+1)=int_val;

        if int_val < (signal_sort(1)+0.25*range_sig)
            type="LOW";
        elseif(int_val > (signal_sort(1)+0.57*range_sig))
            type="HIGH";
        else 
            type="MEDIUM";
        end
        disp("Avg Intensity: "+int_val+" TimeStepSize: "+count+" Type: "+type);
        count=1;
        sum_int=i;
        temp=i;
    end
end
figure;
scatter(intensityArr,TimeArr,'.');
xlabel("Intensity");
ylabel("TimeStep");
grid on;
title("Time Step size Vs Intensity");



% You need to plot the count vs timeStep for each of the signal types
% You need to show for HIGH there are how many instances are there of a t- time step
% Firstly we make an array of avg intensity signals and time_steps

% For HIGH signals
% Below are the timesteps of all HIGH signals
High_intensity = intensityArr(intensityArr > (signal_sort(1) + 0.75 * range_sig));
High_TimeArr = TimeArr(intensityArr > (signal_sort(1) + 0.75 * range_sig))';
figure("Name", "Distribution of TimeSteps HIGH");
histogram(High_TimeArr, 'Normalization', 'count', 'EdgeColor', 'none');
xlabel("TimeStepSize");
ylabel("# of instances with TimestepSize");

% For LOW signals
% Below are the timesteps of all LOW signals
Low_intensity = intensityArr(intensityArr < (signal_sort(1) + 0.25 * range_sig));
Low_TimeArr = TimeArr(intensityArr < (signal_sort(1) + 0.25 * range_sig))';
figure("Name", "Distribution of TimeSteps LOW");
histogram(Low_TimeArr, 'Normalization', 'count', 'EdgeColor', 'none');
xlabel("TimeStepSize");
ylabel("# of instances with TimestepSize");



% For MEDIUM signals
% Below are the timesteps of all MEDIUM signals
Medium_intensity = intensityArr((intensityArr > (signal_sort(1) + 0.25 * range_sig)) & (intensityArr < (signal_sort(1) + 0.75 * range_sig)));
Medium_TimeArr = TimeArr((intensityArr > (signal_sort(1) + 0.25 * range_sig)) & (intensityArr < (signal_sort(1) + 0.75 * range_sig)))';
figure("Name","Distribution of TimeSteps Medium");
xlabel("TimeStepSize");
ylabel("# of instances with TimestepSize");
pd = fitdist(Medium_TimeArr,'Normal');
x_values = linspace(min(Medium_TimeArr), max(Medium_TimeArr), 100); % Generating x values for smooth plotting
y_values = pdf(pd, x_values); % Evaluating the PDF at x values
plot(x_values, y_values);
