function [P1,P2] = eyeDetect(eyeMapImage, faceMaskIm)
%EYEDETECT From an eye map, this function detects the eyes and calculate
%the distance between them 
%I = rgb2gray(image)

%% Make a mask from eyeMap and faceMask.

se1 = strel('disk', 10,8);
eyeMapBlur = imdilate(eyeMapImage, se1);

se2 = strel('disk', 10,8);
faceMaskIm = imerode(faceMaskIm, se2);

% figure; imshow(faceMaskIm);

BW2 = eyeMapBlur.*faceMaskIm;
Max = max(BW2(:));
Min = min(BW2(:));
scaled = (BW2 - Min) ./ (Max - Min);

% figure; imshow(scaled);

% Final mask
res = im2bw(scaled, 0.8);
figure; imshow(res);

%% Find eyes!
[centers, radii, metric] = imfindcircles(res,[5 20]);

% Find the two largest circles.
maxR = 0;
index = -1;
index2 = -1;
for i = 1:size(radii)
    if (radii(i) > maxR)
        maxR = radii(i);
        index = i;
    end
end
maxR = 0;
for i = 1:size(radii)
    if(index ~= i)
        if (radii(i) > maxR)
            maxR = radii(i);
            index2 = i;
        end
    end
end

P1 = centers(index,:);
P2 = centers(index2,:);

% Make sure P1 is left to p2 in the image
if(P1(1) > P2(1) )
    temp = P1;
    P1 = P2;
    P2 = temp;
end

viscircles([P1 ;P2], [radii(index) ;radii(index2)], 'EdgeColor','b');
