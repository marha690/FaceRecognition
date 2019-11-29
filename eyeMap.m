function eyeMapImage = eyeMap(image,faceMask)
%EYEMASK Returns an eye mask if eyes can be determined in an image
%of a face. Will check weather the eyes consists in the facemask or not. 

%% Get chrominance and luminance eye maps

mapC = eyeMapC(image);
mapL = eyeMapL(image);

%% Extra check, compare with faceMask


%% The final eye mask is eyemapC AND eyemapL, Chrominance and Luminance

eyeMapImage = mapC .* mapL;

%% Do we need to use more morphological operations??

end

