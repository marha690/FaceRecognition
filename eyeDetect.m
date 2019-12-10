% function [P1,P2] = eyeDetect(eyeMapImage, faceMaskIm)
% %EYEDETECT From an eye map, this function detects the eyes and calculate
% %the distance between them 
% %I = rgb2gray(image)
% 
% %% Make a mask from eyeMap and faceMask.
% res = combinedMask(eyeMapImage, faceMaskIm);
% 
% %% Find eyes!
% 
% [NumOfPoints, Points] = blobData(res);
% 
% if(NumOfPoints < 2)
%    P1 = -1; % Err, image will not be taken in consideration. 
%    P2 = -1;
% else
%     P1 = [Points(1,2) Points(1,1)];
%     P2 = [Points(2,2) Points(2,1)];
% end
% 
% % Make sure P1 is left to P2.
% if(P1(1) > P2(1) )
%     temp = P1;
%     P1 = P2;
%     P2 = temp;
% end
% 

function [P1,P2] = eyeDetect(eyeMapImage, faceMaskIm, Image)
%EYEDETECT From an eye map, this function detects the eyes and calculate
%the distance between them 
%I = rgb2gray(image)

%% Make a mask from eyeMap and faceMask.
res = combinedMask(eyeMapImage, faceMaskIm);


%% Find eyes!
[NumOfPoints, Points] = blobData(res);

resultMask = res .* im2double(rgb2gray(Image));
[centers,radii] = imfindcircles(resultMask,[6 17],'ObjectPolarity','dark', ...
    'Sensitivity',0.93);


if(NumOfPoints < 2)
   P1 = -1; % Err, image will not be taken in consideration. 
   P2 = -1;
else
    if(size(radii) < 2)
        P1 = [Points(1,2) Points(1,1)];
        P2 = [Points(2,2) Points(2,1)];
    else
        %Find the closest circles to the pos.
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
    
    
        if( sqrt((Min1(1) * Min1(1)) + (Min1(2) * Min1(2))) < 10 )
            P1 = centers(index1,:);
        else
            P1 = Blob1;
        end
        
        if( sqrt((Min2(1) * Min2(1)) + (Min2(2) * Min2(2))) < 10 )
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


