function mask = faceMask(inputImage)
%FACEMASK 
% This function takes an image as input
% returns a mask of the face in the image, if existing

%% Create a binary output image
H = size(inputImage, 1);
W = size(inputImage, 2);
maskImage = zeros(H, W);

%% Illumination Compensation

% Call for Martins algorithm

%% Convert to YCbCr color space 
YCbCr = rgb2ycbcr(inputImage);
Y = YCbCr(:,:,1);
Cb = YCbCr(:,:,2);
Cr = YCbCr(:,:,3);

%% Detect skin, find from threshold in color

% Thresholds as proposed by Rahman, Jhumur, Das, Ahmad in article
% [r,c,v] = find(Cb>70 & Cb<135 & Cr>90 & Cr<130 & Y>90 & Y<180);
[r,c,v] = find(Cb>=70 & Cb<=120 & Cr>=135 & Cr<=173);
    numind = size(r,1);

for i=1:numind
        inputImage(r(i),c(i),:) = [0 0 255];
        maskImage(r(i),c(i)) = 1;
end

SE = strel('disk', 4);
b2 = imopen(maskImage, SE);
b_clean = imclose(b2, SE); % Cleaned up binary image
%imshow(b_clean);
mask = im2double(imfill(b_clean,'holes'));
%figure;imshow(mask);
end

