function test = eyeDetect(eyeMapImage, faceMaskIm)
%EYEDETECT From an eye map, this function detects the eyes and calculate
%the distance between them 
%I = rgb2gray(image)
I = imbinarize(eyeMapImage);


BW = edge(eyeMapImage,'prewitt');
[H,T,R] = hough(BW,'RhoResolution',0.5,'Theta',-90:0.5:89);
%imshow(BW); figure; imshow(faceMaskIm);

eyes = I.*eyeMapImage;
%imshow(eyes); %figure; imshow(eyeMapImage);
%figure; imshow(I); figure;
se = strel('disk', 8,8);
BW2 = imdilate(eyes, se);
BW2 = im2bw(BW2, 0.4);

se = strel('disk',8);
BW2 = imdilate(I,se);
% Label the blobs.
BW2 = im2bw(rescale(BW2.*eyes), 0.35).*faceMaskIm;
labeledImage = bwlabel(BW2);
measurements = regionprops(labeledImage,'Area','Perimeter');
% Do size filtering and roundness filtering.
% Get areas and perimeters of all the regions into single arrays.
allAreas = [measurements.Area]
allPerimeters = [measurements.Perimeter]
% Compute circularities.
circularities = allPerimeters.^2 ./ (4*pi*allAreas)
% Find objects that have "round" values of circularities.
maxAllowableArea = 50000;
keeperBlobs = circularities < 5 & allAreas < maxAllowableArea % Whatever values you want.
% Get actual index numbers instead of a logical vector
% so we can use ismember to extract those blob numbers.
roundObjects = find(keeperBlobs);

% Compute new binary image with only the small, round objects in it.
binaryImage = ismember(labeledImage, roundObjects) > 0;
%binaryImage = binaryImage.*faceMaskIm;
imshow(binaryImage);
%subplot(2,2,4);
% Remeasure with this new segmentation.
% Label the blobs.
labeledImage = bwlabel(binaryImage);
measurements = regionprops(labeledImage,'Area','Perimeter', 'Centroid');
% Get areas and perimeters of all the regions into single arrays.
allAreas = [measurements.Area];
allPerimeters = [measurements.Perimeter];
allCentroids = [measurements.Centroid];
centroidX = allCentroids(1:2:end);
centroidY = allCentroids(2:2:end);
% Plot circles around them
%hold on;

eyeCandidates = [];

% for k = 1 : length(centroidX);
%    n = faceMaskIm(floor(centroidX(k)), floor(centroidY(k)));
%    if(n == 1)
%       plot(centroidX(k), centroidY(k), ...
%       'ro', 'MarkerSize', 20, 'LineWidth', 2);
%       eyeCandidates = [eyeCandidates; [floor(centroidX(k)), floor(centroidY(k))]];
%    end
% 
% end

%eyeCandidates

%imshow(BW2);
%B = bwboundaries(BW, 'noholes');
%coord = [];


%     
% maxValue = max(eyeMapImage(:));
% [rowsOfMaxes colsOfMaxes] = find(eyeMapImage == maxValue)
% 
% trueEyes = zeros(0);
% [dimH, dimW] = size(eyeMapImage);
% 
% eyeCandidates = imfindcircles(eyes, 0.5);
% len = length(eyeCandidates);
% for K=1:1:len
%     hold on;
%     if (round(eyeCandidates(K,1)) <= dimH) && (round(eyeCandidates(K,2)) <= dimW)
%         if eyeMapImage(round(eyeCandidates(K,1)), round(eyeCandidates(K,2))) <= 0.8 
%                 %plot(eyeCandidates(K,1), eyeCandidates(K,2), 'b*', 'MarkerSize', 5, 'LineWidth', 5);
%         end
%     end
% end
% 
% finalEyeMap = bwareafilt(logical(eyes),40);
%imshow(finalEyeMap);
test = eyeMapImage;
end

