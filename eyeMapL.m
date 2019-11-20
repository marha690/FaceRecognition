function eyeMapLuminance = eyeMapL(image)
%EYEMASKL Using the fact that eyes usually contains both dark and bright
% pixels in the luma component, we use this to emphazise these pixels
% around eye regions using morphological operations

ycbcr_image = rgb2ycbcr(image);
Y = im2double(ycbcr_image(:,:,1)); %Get the luminance channel

%% Morphological operations

diskSize = 8;
kernel = strel('disk', diskSize);
dilation = imdilate(Y, kernel);
%imshow(dilation);
erosion = imerode(Y, kernel);
%figure; imshow(erosion);
eyeMap = dilation ./ (erosion+1); 

%figure; imshow(eyeMap);
eyeMapLuminance = eyeMap;
end

