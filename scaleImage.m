function ScaledImage = scaleImage(im, P1, P2, PixelsBetweenEyes)

Len = norm(P2 - P1);

scaleFactor = PixelsBetweenEyes / Len;

ScaledImage = imresize(im,scaleFactor);