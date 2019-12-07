function [P1, P2] = eyeDetect(eyeMapImage, faceMaskIm)
%EYEDETECT From an eye map, this function detects the eyes and calculate
%the distance between them 
%I = rgb2gray(image)

%% Make a mask from eyeMap and faceMask.

se1 = strel('disk', 10,8);
eyeMapBlur = imdilate(eyeMapImage, se1);

se2 = strel('disk', 10,8);
faceMaskIm = imerode(faceMaskIm, se2);

%figure; imshow(faceMaskIm);

BW2 = eyeMapBlur.*faceMaskIm;
Max = max(BW2(:));
Min = min(BW2(:));
scaled = (BW2 - Min) ./ (Max - Min);

% figure; imshow(scaled);

% Final mask
res = im2bw(scaled, 0.8);
[rows, columns, numberOfColorChannels] = size(res);

halfMask = zeros(rows,columns);
halfMask(1:floor(rows/1.5),:) = 1;

res2 = res.*halfMask;
res = im2bw(res2, 0.5);

 [rows, cols] = size(res);

 res = 255.*double(res)./max(max(double(res)));

%     % Thresholding the map to create map with intensities of only 0 and 255
%     for row = 1:rows
%         for col = 1:cols
%             if(res(row,col) > 201)
%                 res(row,col) = 255;
%             else
%                 res(row,col) = 0;
%             end
%         end
%     end


%% Find eyes!

[L,n] = bwlabel(res);
stats = regionprops(L, 'centroid', 'MajorAxisLength','MinorAxisLength');
% Draw an asterisk 

figure(1);imshow(res);
centroids = cat(1, stats.Centroid);
hold on
centers = stats.Centroid;
diameters = mean([stats.MajorAxisLength stats.MinorAxisLength],2);
radii = diameters/2;
centers
for k = 1:length(centroids)
    viscircles(centroids(k, :), radii);
end
viscircles(centers,radii);
%plot(P1, P2, 'r*');
bestPoint = 0;
points = [];

 for i = 1:length(centroids)
        for j = (i+1):length(centroids)
            delta = abs(centroids(i, :) - centroids(j, :));
            euclDist = sqrt(delta(1)^2 + delta(2)^2);
            
            point.p1 = centroids(i, :);
            point.p2 = centroids(j, :);
            point.delta = delta;
            point.eucl = euclDist;

            points = [points point];
        end
 end

 bestPoint = 0;
    for i = 1:length(points)
  %      P = [centroids(i,1), centroids(i,2)]

         if i == 1
             bestPoint = points(i);
        elseif bestPoint.delta(1) > points(i).delta(1) && points(i).eucl > 100 
            bestPoint = points(i);
         end
    end
    

    

P1 = bestPoint.p1
P2 = bestPoint.p2

plot(P1, P2, 'rx');

[centers, radii, metric] = imfindcircles(res,[6 18]);

if(size(radii) < 2)
    P1 = -1;
    P2 = -1;
    return;
end

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

%viscircles([P1 ;P2], [radii(index) ;radii(index2)], 'EdgeColor','b');
% viscircles(centers, radii, 'EdgeColor','b');
