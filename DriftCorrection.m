%This code takes in the real QD video traces and outputs drift-corrected video. Here, the user first needs to mention the boundary coordinates of the region of interest.

%Same code as in driftCorrection3 but here we regurlarly ask the user if
%the correction is correction. If not should should be the direction of
%correction (u,b,r,l,N) N-Not required

%Also the error in prv codes is corrected

clc;
clear;

%Input the video file_name
file='Sample1.avi';                                         
folder = fileparts(which(file));              %First get the folder that it lives in.
inputFullFileName = fullfile(folder, file);
% Check to see that it exists.
if ~exist(inputFullFileName, 'file')                                       
	strErrorMessage = sprintf('File not found:\n%s\nYou can choose a new one, or cancel', inputFullFileName);
	response = questdlg(strErrorMessage, 'File not found', 'OK - choose a new movie.', 'Cancel', 'OK - choose a new movie.');
	if strcmpi(response, 'OK - choose a new movie.')
		[baseFileName, folderName, FilterIndex] = uigetfile('*.avi');      
		if ~isequal(baseFileName, 0)
			inputFullFileName = fullfile(folderName, baseFileName);
		else
			return;
		end
	else
		return;
	end
end
% Open up the VideoReader for reading an input video file.
inputVideoReaderObject = VideoReader(inputFullFileName);
% Determine how many frames there are.
numberOfFrames = inputVideoReaderObject.NumberOfFrames;
inputVideoRows = inputVideoReaderObject.Height
inputVideoColumns = inputVideoReaderObject.Width


% Create a VideoWriter object to write the video out to a new, different file.
outFile=sprintf('New_%s',file);
outputFullFileName = fullfile(pwd, outFile);
outputVideoWriterObject = VideoWriter(outputFullFileName);
fps=inputVideoReaderObject.FrameRate;
outputVideoWriterObject.FrameRate=fps;
open(outputVideoWriterObject);

%display reference image
M1=read(inputVideoReaderObject,1);   %rgb color matrix uint8 datatype
figure('Name','Reference Image');
imshow(M1);
grid on;

%User provides the rectangular ROI coordinates in the M1
%Coordinates are from top-left in clockwise flow
%First value is actually col
%second value is actually row
% ArrM1=[235,243;  %Top-left corner 
%     434,243;     %Top-right corner
%     434,400;     %bottom-right
%     235,400      %bottom-left
%     ];    
disp("Please Enter the (Region of Interest)ROI's boundary coordinates");
disp("Enter the coordinates from the Top-left corner in clockwise flow");
disp("You may use DataTips option under Tools tooglebar");
ArrM1=[];
args=["Coordinates of Top-left: Eg(x,y) ";"Coordinates of Top-Right: ";"Coordinates of Bottom-Right: ";"Coordinates of Bottom-left: "];
for i=1:4
    resp1=strrep(input(args(i),'s'),',',' ');
    row=reshape(sscanf(resp1,'%f'),1,[]);
    ArrM1(end+1,:)=row;
end

%Length and width of ROI
len= ArrM1(4,2)-ArrM1(1,2);  %vertical
wid= ArrM1(2,1)-ArrM1(1,1);  %horizontal

prompt="Manual drift correction up(u) down(d) right(r) left(l) n(None)";
parr=[1,2,3,4,5];
rnum=round(numberOfFrames/5);
img_no=1;
for i=1:numberOfFrames
    Mi=read(inputVideoReaderObject,i);
    if (i==1) 
        ArrMi =ArrM1;
    end
    ArrMi=Similarity_offset(Mi,M1,ArrM1,ArrMi);

%     if ismember(i,rnum*parr)        %Manual occasional drift correction
%         resp= input(prompt,"s");
%         switch(resp)
%             case "u"
%                 ArrMi =ArrMi + [0,1;0,1;0,1;0,1];
%             case "d"
%                 ArrMi =ArrMi + [0,-1;0,-1;0,-1;0,-1];
%             case "r"
%                 ArrMi =ArrMi + [1,0;1,0;1,0;1,0];
%             case "l"
%                 ArrMi =ArrMi + [-1,0;-1,0;-1,0;-1,0];
%             otherwise
%                 ArrMi=ArrMi;
%         end
%     end
    
    Mi_ROI=ROIfromArr(Mi,ArrMi);
    
%Mi_ROIImg=mat2gray(Mi_ROI,[min(Mi_ROI(:)),max(Mi_ROI(:))]);
    title("Image"+img_no+"/"+numberOfFrames);
    imshow(Mi_ROI);
    
%Also write into the output video object
    writeVideo(outputVideoWriterObject, Mi_ROI);

    pause(0.1); 
    hold on; 

    img_no=img_no+1;
end

hold off;
% Close the output video object.  You don't need to close the input video reader..
close(outputVideoWriterObject);


% Alert user that we're done.
finishedMessage = sprintf('Done!  It processed %d frames of\n"%s" and created output video\n%s.\nClick OK to see the output video.', img_no, inputFullFileName, outputFullFileName);
fprintf('%s\n', finishedMessage); % Write to command window.
uiwait(msgbox(finishedMessage)); % Also pop up a message box.
% Play the movie.
winopen(outputFullFileName);


%Function which finds the Boundary coordinates of ROI in M2 which matches
%with the chosen ROI in M1 matrix
%Here 9 combination of possible boundary ROI's are chosen and then using
%correlation of each of those with ROI_M1 matrix we comment on the most
%similar ROI in Mi
%ArrM2p is the previous array matrix
function Opt_ArrM2= Similarity_offset(M2,M1,ArrM1,ArrM2p)  
    M1_ROI= ROIfromArr(M1,ArrM1);

    Opt_ArrM2=ArrM2p; %Most of the time this optimal will stay at the same place
    max_coeff=0;
    %We have 9 possible combinations for ArrM2
    for i=[-1,0,+1]
        for j=[-1,0,+1]
            ArrM2=ArrM2p+[i,j;i,j;i,j;i,j];
            M2_ROI=ROIfromArr(M2,ArrM2);
            corr_m=corrcoef(reshape(double(M1_ROI),[],1),reshape(double(M2_ROI),[],1));
            coeff_val=corr_m(2,1);
            
            if coeff_val>=max_coeff
                max_coeff=coeff_val;
                Opt_ArrM2=ArrM2;
            end
        end
    end
    disp("MAX CORR-COEFF "+max_coeff);

end

%returns ROI matrix from the boundary coordinates
function mat=ROIfromArr(M,ArrM)
    mat=M(ArrM(1,2):ArrM(4,2),ArrM(1,1):ArrM(2,1),:);
end