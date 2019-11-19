function eyeMapChrominance = eyeMapC(image,ycbcr_image)
%EYEMASKC Creates an eye mask for chrominance channel 
% USes that for chrominance around eyes, Cr are low and Cb are high
% Equation fo chrominance eye map: EyeMapC = 1/3 * ((Cb)^2 + (255-Cb)^2 + (Cb/Cr))
% Note that (255-Cb) is the normalized Cb, when negative we set to
% (255-Cb)^2
% All other terms are normalized to the range [0, 255] as well

%% Separate into Chrominance channels and necessary variables
imshow(image); figure; imshow(ycbcr_image);
cb = ycbcr_image(:,:,2);
cr = ycbcr_image(:,:,3);
cb2 = cb.^2;
normCb = (255-cb).^2;
cb_cr = cb./cr;

%% Normalization to range[0,255]

%cb2 = normalize(cb2, 0, 255);
%cb_cr = normalize(cb_cr, 0, 255);

%% Creation of eye map
eyeMap = 1/3 * (cb2 + normCb + cb_cr);

% Normalize?
%eyeMap = uint8(255*mat2gray(eyeMap));
imshow(eyeMap);

eyeMapChrominance = eyeMap;
end
