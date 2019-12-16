function [P1,P2] = eyeDetect(eyeMapImage, faceMaskIm, Image)
%EYEDETECT From an eye map, this function detects the eyes and calculate
%the distance between them 

%% Make a mask from eyeMap and faceMask.

Mask = combinedMask(eyeMapImage, faceMaskIm);

%% Find eyes

[NumOfPoints, Points] = blobData(Mask);

% Find circles inside masked area in the image
resultMask = Mask .* im2double(rgb2gray(Image));
[centers,radii] = imfindcircles(resultMask,[6 17],'ObjectPolarity','dark', ...
    'Sensitivity',0.93);

%% Selection of which points to choose

if(NumOfPoints < 2) % Not enough areas inside the mask
   P1 = -1;  
   P2 = -1;
else
    if(size(radii) < 2) % Can't find circles in original image
        P1 = [Points(1,2) Points(1,1)];
        P2 = [Points(2,2) Points(2,1)];
    else %Find the closest circles to the blobs position
        Blob1 = [Points(1,2) Points(1,1)];
        Blob2 = [Points(2,2) Points(2,1)];
        
        Blob1array = repmat(Blob1, [ size(radii), 1]);
        Blob2array = repmat(Blob2, [ size(radii), 1]);
        
        dist1 = abs(Blob1array-centers);
        dist2 = abs(Blob2array-centers);
        
        Min1 = dist1(1,:);
        index1 = 1;
        Min2 = dist2(1,:);
        index2 = 1;
        for i = 1:size(radii)
            if( (Min1(1) * Min1(1)) + (Min1(2) * Min1(2)) > (dist1(i,1) * dist1(i,1)) + (dist1(i,2) * dist1(i,2)) )
                Min1 = dist1(i,:);
                index1 = i;
            end
            if( (Min2(1) * Min2(1)) + (Min2(2) * Min2(2)) > (dist2(i,1) * dist2(i,1)) + (dist2(i,2) * dist2(i,2)) )
                Min2 = dist2(i,:);
                index2 = i;
            end
        end
    
        % If a circle is close to a blobs min point, the circle is selected
        % as eye point
        MaxDist = 10;
        if( sqrt((Min1(1) * Min1(1)) + (Min1(2) * Min1(2))) < MaxDist )
            P1 = centers(index1,:);
        else
            P1 = Blob1;
        end
        
        if( sqrt((Min2(1) * Min2(1)) + (Min2(2) * Min2(2))) < MaxDist )
            P2 = centers(index2,:);
        else
            P2 = Blob2;
        end
    end
end


% Make sure P1 is left to P2.
if(P1(1) > P2(1) )
    temp = P1;
    P1 = P2;
    P2 = temp;
end


