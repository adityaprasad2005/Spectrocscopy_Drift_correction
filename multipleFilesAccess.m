%This code can be used to access all the existing .xlsx files in that directory and plot them.


list=ls('*.xlsx');
disp('size:'+size(list,1));
i=1;
while i<=size(list,1)
    fileName=list(i,:);
    disp(fileName);
    matrix1=xlsread(fileName);
    signal1=matrix1(:,2);
    plot(signal1);
    xlabel("sample index");
    ylabel("Intensity");
    title(fileName);
    grid on;
    i=i+1;
end