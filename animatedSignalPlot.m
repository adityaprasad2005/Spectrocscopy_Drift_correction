%the user needs to input the xlsx file name, and the signal will be plotted. 

clc;
clear;
%load('simulatedSignal.mat');
filename="for simulated video.xlsx";
signal=xlsread(filename);   %
signal=signal(:,2);

n_samples=length(signal);
curve= animatedline(); 
%'Color','k','LineStyle',':',Marker='o'
% set(gca,'XLim',[1 n_samples],'YLim',[0 1]);
xlabel("sample index");
ylabel("Intensity");
grid on;
title('Animated Signal Plot');

for h=1:n_samples
    addpoints(curve,h,signal(h));
    drawnow;
    pause(.001);
end