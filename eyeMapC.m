function eyeMapChrominance = eyeMapC(image,ycbcr_image)
%EYEMASKC Creates an eye mask for chrominance channel 
% USes that for chrominance around eyes, Cr are low and Cb are high
% Equation fo chrominance eye map: EyeMapC = 1/3 * ((Cb)^2 + (Cr*)^2 + (Cb/Cr))
% Note that Cr* is the normalized Cr when negative set to Cr* = 255-Cr*Cb^2
% All terms are normalized to the range [0, 255]

%% Separate into Chrominance channels and necessary variables
cb = ycbcr_image(:,:,2);
cr = ycbcr_image(:,:,3);
cb2 = cb.^2;
cr2 = 
cb_cr = cb./cr;


%% Normalization to range[0,255]

cb2 = normalizeMatrix(cb2, 0, 255);
cb_cr = normalizeMatrix(cb_cr, 0, 255);

%% Creation of eye map
eyeMask = 

eyeMaskChrominance = eyeMap;
end

