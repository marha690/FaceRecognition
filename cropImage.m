function out = cropImage(im, mid, height, width)
%% Crops image to set height and width
% Cropped image can have +- 1 pixel in width and height.

h = height/2;
w = width/2;
x = mid(1)-w; % Top left x-pos
y = mid(2)-h; % Top left y-pos

out = imcrop(im,[x y width height]);


