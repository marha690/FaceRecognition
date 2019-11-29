function out = scaleImage(im, P1, P2)

Len = norm(P2 - P1);
scaleConstant = 0.01;

scaleFactor = Len * scaleConstant

out = imresize(im,scaleFactor);