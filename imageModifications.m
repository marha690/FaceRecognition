function result = imageModifications(im)

    ImageHeight = 340;
    ImageWidth = 240;
    PixelsBetweenEyes = 100; % Approximative
    result = -1;
    
    %% Gray world lighting compensation
    im = lightCorrection(im);

    %% Rotates the image.
    faceMaskIm = faceMask(im);
    eyeMapn = eyeMap(im, faceMaskIm);
    [P1, P2] = eyeDetect(eyeMapn, faceMaskIm);
    if(P1 == -1)
       return;
    end
    rotIm = faceRotation(im, P1, P2);
    
    %% Scale image
    faceMaskIm = faceMask(rotIm);
    eyeMapn = eyeMap(rotIm, faceMaskIm);
    [P1, P2] = eyeDetect(eyeMapn, faceMaskIm);
    if(P1 == -1)
       return;
    end
    scaledIm = scaleImage(rotIm, P1, P2, PixelsBetweenEyes);
    
    %% Crop Image
    faceMaskIm = faceMask(scaledIm);
    eyeMapn = eyeMap(scaledIm, faceMaskIm);
    [P1, P2] = eyeDetect(eyeMapn, faceMaskIm);
    if(P1 == -1)
       return;
    end
    mid = [P1(1)+floor(PixelsBetweenEyes/2) P1(2)]; % position between eyes.
    cropIm = cropImage(scaledIm, mid, ImageHeight, ImageWidth);
    
    %%
    result = rgb2gray(cropIm);
