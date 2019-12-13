% Returns the gray scale image with only the face visible.
function result = imageModifications(im)

    ImageHeight = 320;
    ImageWidth = 220;
    PixelsBetweenEyes = 100;
    result = -1;

    %% Rotate image.
    faceMaskIm = faceMask(im);
    eyeMapn = eyeMap(im);
    [P1, P2] = eyeDetect(eyeMapn, faceMaskIm, im);
    if(P1 == -1)
       return;
    end
    rotIm = faceRotation(im, P1, P2);
    rotMask = faceRotation(faceMaskIm, P1, P2);
    rotEye  = faceRotation(eyeMapn, P1, P2);

    %% Scale image
    [P1, P2] = eyeDetect(rotEye, rotMask, rotIm);
    if(P1 == -1)
       return;
    end
    scaledIm = scaleImage(rotIm, P1, P2, PixelsBetweenEyes);
    scaleMask = scaleImage(rotMask, P1, P2, PixelsBetweenEyes);
    scaleEye = scaleImage(rotEye, P1, P2, PixelsBetweenEyes);
    
    %% Crop Image
    [P1, ~] = eyeDetect(scaleEye, scaleMask, scaledIm); 
    if(P1 == -1)
       return;
    end
    mid = [P1(1)+floor(PixelsBetweenEyes/2) P1(2)]; % position between eyes.
    cropIm = cropImage(scaledIm, mid, ImageHeight, ImageWidth);
        
    % Test if the image has correct size.
    [resR, resC, ~] = size(cropIm);
    if ( abs(resR - ImageHeight) > 1 || abs(resC - ImageWidth) > 1)
       return; 
    end

    %% Finishing touches on the image.
    lightCorrectedIm = lightCorrection(cropIm);
 	result = imsharpen(lightCorrectedIm,'Radius',2,'Amount',1);
    
 

