%Here, I have created a discrete random signal to simulate a real quantum dot blinking time trace.

clc;
clear all;

%create a simulated signal of 100s where
%Intensity varies randomnly between [0,1]
%Time-step size varies randomnly 

%The signal should be in the form of discrete samples

n_samples=100;
%initialise the random number generator
rng(0,"twister");

signal=zeros([1,n_samples]);
%Now change a randi([1,7],1) num. of samples to a rand(1) value of
%intensity between 0 and 1
time=1;

while (time<100)
    step=randi([1,7]);
    if (time>=94 && time<=100)
        step=100-time;
    end

    signal(time:time+step)=rand();
    
    time = time+ step;
end

figure;
plot(signal);
xlabel("Sample index");
ylabel("Intensity")
title("Signal Discrete");

%save the simulated signal
save ("simulatedSignal.mat","signal")