function result = temporaryFaceFinderFunction(im)

    height = 250;
    width = 200;
    result = -1; 
    %% Gray world lighting compensation
    
%     im = adjustImageValues(im); %old function
    im = lightCorrection(im);
    
    %% Converting image into masks and maps

    % figure; imshow(im);
    faceMaskIm = faceMask(im);
    eyeMapn = eyeMap(im, faceMaskIm);
    [P1, P2] = eyeDetect(eyeMapn, faceMaskIm);
    if(P1 == -1)
       return;
    end
    % figure; imshow(test);
    
    %% Image prerations
    
    % Rotates the image.
    rotIm = faceRotation(im, P1, P2);
    
    % Crop Image
    mid = [P1(1)+50 P1(2)];
    cropIm = cropImage(rotIm, P1, height, width);
    

    result = cropIm;