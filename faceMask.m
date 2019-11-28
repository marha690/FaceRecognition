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
[r,c,v] = find(Cb>=70 & Cb<=135 & Cr>=125 & Cr<=190 & Y>70 & Y<180);
    numind = size(r,1);

for i=1:numind
        inputImage(r(i),c(i),:) = [0 0 255];
        maskImage(r(i),c(i)) = 1;
end

SE = strel('disk', 4);
b2 = imopen(maskImage, SE);
b_clean = imclose(b2, SE); % Cleaned up binary image
% figure;imshow(b_clean);
mask = im2double(imfill(b_clean));

% Make morphological operation to remove holes in the mask.
se = strel('disk',10,8)
mask = imdilate(mask, se);
mask = imfill(mask);
mask = imerode(mask, se);

% figure;imshow(mask);
end