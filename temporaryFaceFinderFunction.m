function result = temporaryFaceFinderFunction(im)
    
    % Gray world ? lighting compensation
    im = adjustImageValues(im);
    
    %Jossan, do your magic here :)
    im = rgb2gray(im); %Grayscale!
    result = im(1:300,1:350); %Crop!