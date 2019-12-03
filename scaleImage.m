function out = scaleImage(im, P1, P2)

Len = norm(P2 - P1);

PixelsBetweenEyes = 100; %Approximative.

scaleFactor = PixelsBetweenEyes / Len;

out = imresize(im,scaleFactor);