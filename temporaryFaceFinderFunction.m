function result = temporaryFaceFinderFunction(im)

    height = 340;
    width = 240;
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
    scaledIm = scaleImage(rotIm, P1, P2);
    
    %% Crop Image
    faceMaskIm = faceMask(scaledIm);
    eyeMapn = eyeMap(scaledIm, faceMaskIm);
    [P1, P2] = eyeDetect(eyeMapn, faceMaskIm);
    if(P1 == -1)
       return;
    end
    mid = [P1(1)+50 P1(2)];
    cropIm = cropImage(scaledIm, mid, height, width);
    
    %%
    result = rgb2gray(cropIm);
%     figure; imshow(result);