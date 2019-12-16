function out = scaleImage(im, P1, P2, PixelsBetweenEyes)
% Scales an input image so the number of pixels between P1 and P2 is equal
% to PixelsBetweenEyes

Len = norm(P2 - P1);

scaleFactor = PixelsBetweenEyes / Len;

out = imresize(im,scaleFactor);