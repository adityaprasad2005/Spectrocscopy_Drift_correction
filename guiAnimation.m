%In this code file, the user needs to provide two signal time traces of the same sample length. The code-generated simulation video of the quantum blinking can be seen in the figure window. You may use "for simulated video.xlsx" file

clc;
clear;
%load('SimulatedSignal.mat');
matrix1=xlsread('for simulated video.xlsx','Sheet1');
matrix2=xlsread('for simulated video.xlsx','Sheet2');
signal1=matrix1(:,2);

% plot of the time trace
figure;
plot(signal1);
xlabel("Index");
ylabel("Intensity");


signal2=matrix2(:,2);
pixels=16;

disp(size(signal1));
disp(size(signal2));

%Here we'd have a 3*3 matrix of pixels
%And the central pixel has to be assigned with dynamic colors

f=figure();
title('GUI animation');
hold on;
grid off;
% grid(gca,'off');
f.GraphicsSmoothing='off';

% grid minor;
set(gca,'XLim',[0 pixels],'YLim',[0 pixels]);   %Every QuantumDot is assigned a 3*3 pixel area
xlim([0,pixels]);
square_middle1=[4,4,5,5;8,9,9,8];
square_middle2=[12,12,13,13;8,9,9,8];
square=[0,0,1,1;0,1,1,0];
c=gray();                             %returns rgb values on the rows of 256*3 colormap array of grey colors
c=flipud(c);                          %smallest index is the lighest shade, and the shade darkens with the index
axis equal;

num=pixels*pixels -1;
m1=min(signal1(:,1));
m2=min(signal2(:,1));

disp("please wait while grid is getting formed...")
%fill() into all the num squares
for i=0:num
    x=mod(i,pixels);
    y=floor(i/pixels);
    fill(square(1,:)+[x,x,x,x],square(2,:)+[y,y,y,y],c(m1+1,:));
    %pause(0.0001);
end


%Dynamically changing the square_middle color with the signal
l1=length(signal1(:,1));
l2=length(signal2(:,1));
for i = 1:l1
    fill(square_middle1(1,:),square_middle1(2,:),c(signal1(i,1)+1,:));
    fill(square_middle2(1,:),square_middle2(2,:),c(signal2(i,1)+1,:));
    disp("Signal 1: "+signal1(i,1)+ "    Signal 2: "+signal2(i,1));
    pause(0.00001);
end
