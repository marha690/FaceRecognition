% Cropped image can have +- 1 pixel in width and height.
function out = cropImage(im, mid, height, width)

h = height/2;
w = width/2;
x = mid(1)-w; % Top left x-pos
y = mid(2)-h; % Top left y-pos

out = imcrop(im,[x y width height]);


