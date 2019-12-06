function [P1,P2] = eyeDetect(eyeMapImage, faceMaskIm)
%EYEDETECT From an eye map, this function detects the eyes and calculate
%the distance between them 
%I = rgb2gray(image)

%% Make a mask from eyeMap and faceMask.
res = combinedMask(eyeMapImage, faceMaskIm);

%% Find eyes!

[NumOfPoints, Points] = blobData(res);

if(NumOfPoints < 2)
   P1 = -1; % Err, image will not be taken in consideration. 
   P2 = -1;
else
    P1 = [Points(1,2) Points(1,1)];
    P2 = [Points(2,2) Points(2,1)];
end

% Make sure P1 is left to P2.
if(P1(1) > P2(1) )
    temp = P1;
    P1 = P2;
    P2 = temp;
end

