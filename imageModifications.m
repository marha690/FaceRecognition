function result = imageModifications(im)
% Returns an image of only the face visible, correctly cropped,
% scaled and color corrected.
% Returns -1 if no face was detected

%% Set proportions and variables

ImageHeight = 320;
ImageWidth = 220;
PixelsBetweenEyes = 100; % Approximative
result = -1;

%% Rotate the image.

faceMaskIm = faceMask(im);
eyeMapn = eyeMap(im, faceMaskIm);
[P1, P2] = eyeDetect(eyeMapn, faceMaskIm, im);
if(P1 == -1)
    return;
end
rotIm = faceRotation(im, P1, P2);
rotMask = faceRotation(faceMaskIm, P1, P2);
rotEye  = faceRotation(eyeMapn, P1, P2);

%% Scale the image

[P1, P2] = eyeDetect(rotEye, rotMask, rotIm);
if(P1 == -1)
    return;
end
scaledIm = scaleImage(rotIm, P1, P2, PixelsBetweenEyes);
scaleMask = scaleImage(rotMask, P1, P2, PixelsBetweenEyes);
scaleEye = scaleImage(rotEye, P1, P2, PixelsBetweenEyes);

%% Crop the Image

[P1, P2] = eyeDetect(scaleEye, scaleMask, scaledIm);
if(P1 == -1)
    return;
end

mid = [P1(1)+floor(PixelsBetweenEyes/2) P1(2)]; % position between eyes.
cropIm = cropImage(scaledIm, mid, ImageHeight, ImageWidth);

% Check if the image has the correct size
[resR, resC, ~] = size(cropIm);
if ( abs(resR - ImageHeight) > 1 || abs(resC - ImageWidth) > 1)
    return;
end

%% Light correct the result

result = lightCorrection(cropIm);
result = imsharpen(result,'Radius',2,'Amount',1);
