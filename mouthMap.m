function mouthMapImage = mouthMap(image, faceMask)
%MOUTHMAP Creating a mouth map from an image. Using the fact that in a
%face, the mouth region contains more red component compared to the blue
%component than in other facial regions
% Using the equation mouthMap = Cr^2*(Cr^2-n*Cr/Cb)^2
% n = number of pixels inside the face mask

%% Convert to YCbCr color space and get channels

ycbcr = rgb2ycbcr(image);
cb = im2double(ycbcr(:,:,2));
cr = im2double(ycbcr(:,:,3));

%% Calculate terms for equation

cr2 = cr.*cr;
cr_cb = cr./cb;
n = nnz(faceMask); %Number of non zero elements in face mask

%% Normalization

cr2 = rescale(cr2)*255;
cr_cb = rescale(cr_cb)*255;

%% Calculate mouth map

mouthMap =  cr2.*(cr2 - ((cr_cb))).^2;
mouthMap = rescale(mouthMap);

mouthMapImage = mouthMap;
end

