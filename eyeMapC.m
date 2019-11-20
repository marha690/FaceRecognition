function eyeMapChrominance = eyeMapC(image)
%EYEMASKC Creates an eye mask for chrominance channel 
% USes that for chrominance around eyes, Cr are low and Cb are high
% Equation fo chrominance eye map: EyeMapC = 1/3 * ((Cb)^2 + (Cr*)^2 + (Cb/Cr))
% Note that Cr* is the inverse Cr, when negative we set to
% (255-Cr)
% All other terms are normalized to the range [0, 255] as well

%% Separate into Chrominance channels and necessary variables

ycbcr_image = rgb2ycbcr(image);
cb = im2double(ycbcr_image(:,:,2));
cb2 = cb.*cb;
cr = im2double(ycbcr_image(:,:,3));
invCr2 = (255-cr).^2;
cb_cr = cb./cr;

%% Normalization to range[0,255] (first normalize to [0,1] then multiply with 255)

cb2 = rescale(cb2)*255;
invCr2 = rescale(invCr2)*255;
cb_cr = rescale(cb_cr)*255;

%% Creation of eye map

eyeMap = 1/3 * (cb2 + invCr2 + cb_cr);
eyeMap = rescale(eyeMap); %Normalize between [0,1]
%imshow(eyeMap);

eyeMapChrominance = eyeMap;
end

