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
Cb = YCbCr(:,:,2);
Cr = YCbCr(:,:,3);

%% Detect skin, find from threshold in color

[r,c,v] = find(Cb>=70 & Cb<=120 & Cr>=135 & Cr<=173);
    numind = size(r,1);

for i=1:numind
        inputImage(r(i),c(i),:) = [0 0 255];
        maskImage(r(i),c(i)) = 1;
end

%[SkinIndexRow,SkinIndexCol] =find(Cr > 145 & Cr<180);
%for i=1:length(SkinIndexRow)
%    maskImage(SkinIndexRow(i),SkinIndexCol(i))=1;
%end

%maskIm = im2double(imfill(maskImage,'holes'));
%seD = strel('diamond',1);
%maskIm = imerode(maskIm,seD);
%maskIm = imerode(maskIm,seD);
SE = strel('disk', 4);
b2 = imopen(maskImage, SE);
b_clean = imclose(b2, SE); % Cleaned up binary image

mask = im2double(imfill(b_clean,'holes'));
imshow(mask);
end

