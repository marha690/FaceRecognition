function result = temporaryFaceFinderFunction(im)
    
    % Gray world lighting compensation
%     im = adjustImageValues(im); %old function
    im = lightCorrection(im);
    
    %% Converting image into masks and maps

    % figure; imshow(im);
    faceMaskIm = faceMask(im);
    % imshow(faceMaskIm);
    eyeMapn = eyeMap(im, faceMaskIm);

    [P1, P2] = eyeDetect(eyeMapn, faceMaskIm);
    % figure; imshow(test);
    
    %Jossan, do your magic here :)
%     im = rgb2gray(im); %Grayscale!
    result = im(1:300,1:350); %Crop!