function eyeMaskImage = eyeMask(image,image_ycbcr, faceMask)
%EYEMASK Returns an eye mask if eyes can be determined in an image
%of a face. Will check weather the eyes consists in the facemask or not. 

%% The final eye mask will be the sum of two separate eye masks, Chrominance and Luminance


eyeMaskImage = originalImage + YCbCr_original + faceMask;
end

