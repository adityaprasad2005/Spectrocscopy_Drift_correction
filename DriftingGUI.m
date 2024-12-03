%This file generates a GUI simulation of two blinking QD time traces taken from  "for simulated video.xlsx" file. Random drifting has been induced. This was to be used for preliminary testing of the drift correction algorithm.

clc;
clear;

%Here we'd have two chunks of QDs and their central QD willbe blinking same
%Step1- Add a random no. of randomnly blinking low-state QDs
%Step2- Add a random no. of randomnly blinking low-state QDs around chunks
%Step3- Randomly introduce drift in the mean positions of the chunks

rng(10,"twister");
%load('SimulatedSignal.mat');
matrix1=xlsread('for simulated video.xlsx','Sheet1');
matrix2=xlsread('for simulated video.xlsx','Sheet2');
signal1=matrix1(:,2);
signal2=matrix2(:,2);

% plot of the time trace
% figure;
% plot(signal1);
% xlabel("Index");
% ylabel("Intensity");

pixels=16;

disp(size(signal1));
disp(size(signal2));

%Here we'd have a 3*3 matrix of pixels
%And the central pixel has to be assigned with dynamic colors
figure();
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
square_middle1_orig=[4,4,5,5;8,9,9,8];
square_middle2_orig=[12,12,13,13;8,9,9,8];
square=[0,0,1,1;0,1,1,0];
c=gray();                             %returns rgb values on the rows of 256*3 colormap array of grey colors
%c=flipud(c);                         %smallest index is the lighest shade, and the shade darkens with the index
axis equal;

num=pixels*pixels ;
m1=min(signal1(:,1));
m2=min(signal2(:,1));

disp("please wait while grid is getting formed...")
%fill() into all the num squares
for i=0:(num-1)
    x=mod(i,pixels);
    y=floor(i/pixels);
    fill(square(1,:)+[x,x,x,x],square(2,:)+[y,y,y,y],c(m1+1,:));
    if (i>100)
        m1=m2;
    end
end


%Dynamically changing the square_middle color with the signal
l1=length(signal1(:,1));
l2=length(signal2(:,1));
for i = 1:l1
    fill(square_middle1(1,:),square_middle1(2,:),c(signal1(i,1)+1,:));
    fill(square_middle2(1,:),square_middle2(2,:),c(signal2(i,1)+1,:));
    disp("Signal 1: "+signal1(i,1)+ "    Signal 2: "+signal2(i,1));
    
    %Add 8 low-QDs to constitute QD chunks
    for k=0:8
        if (k==4)
            continue
        end
        x_shft=mod(k,3)-1;
        y_shft=floor(k/3)-1;
        if (abs(randn(1))<1.5)
            fill(square_middle1(1,:)+[x_shft,x_shft,x_shft,x_shft],square_middle1(2,:)+[y_shft,y_shft,y_shft,y_shft],c(floor(signal1(i,1)/3)+randi([1,30],1),:));
        end
        if(abs(randn(1))<1.5)
            fill(square_middle2(1,:)+[x_shft,x_shft,x_shft,x_shft],square_middle2(2,:)+[y_shft,y_shft,y_shft,y_shft],c(floor(signal2(i,1)/3)+randi([1,30],1),:));
        end
    end


    %Add a certain no. of QDs on periphery
    n= randi([1,5],1);
    x_vals=randsample([0,1,2,3,4,13,14,15],n);
    y_vals=randsample([0,1,2,3,4,13,14,15],n);
    for j=1:n
        x_pos=x_vals(1,j);
        y_pos=y_vals(1,j);
        col=randi([50,100],1);
        fill(square(1,:)+[x_pos,x_pos,x_pos,x_pos],square(2,:)+[y_pos,y_pos,y_pos,y_pos],c(col,:));
    end
    pause(0.00001);
    
    %clear all the pixels
    fill(square(1,:)+[-2,-2,pixels+2,pixels+2],square(2,:)+[-2,pixels+2,pixels+2,-2],c(1,:));
   
    %Introducing shift by shifting the mean of the chunks
    x_shft=randn(1)/10; 
    y_shft=randn(1)/10;
    square_middle1(1,:)=square_middle1_orig(1,:)+[x_shft,x_shft,x_shft,x_shft];
    square_middle1(2,:)=square_middle1_orig(2,:)+[y_shft,y_shft,y_shft,y_shft];
    square_middle2(1,:)=square_middle2_orig(1,:)+[x_shft,x_shft,x_shft,x_shft];
    square_middle2(2,:)=square_middle2_orig(2,:)+[y_shft,y_shft,y_shft,y_shft];   
end
