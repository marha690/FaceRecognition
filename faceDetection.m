function faceImage = faceDetection(inputImage)
%FACEDETECTION Function for finding the face in an image
% This function takes an image as input
% returns a cropped version with only the face as output

%% Turn the image into grayscale 

bwImage = rgb2gray(inputImage);

%% Create a binary gradient mask

threshold = 0.3;
[~,threshold] = edge(bwImage,'sobel'); %Using Sobel operator to determine threshold
fudgeFactor = 0.5;
BWs = edge(bwImage,'sobel',threshold * fudgeFactor);

%level = graythresh(bwImage); %Otsu's algorithm
%thresholdIm = imbinarize(bwImage, level);

%% Dilation

se90 = strel('line',3,90);
se0 = strel('line',3,0);

BWsdil = imdilate(BWs,[se90 se0]);


%% Filling interior

BWdfill = imfill(BWsdil,'holes');

%% Clear border & smoothing

seD = strel('diamond',1);
BWfinal = imerode(BWdfill,seD);
BWfinal = imerode(BWfinal,seD);


faceImage = BWfinal;
end

