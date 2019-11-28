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
imshow(eyes); figure;
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
maxAllowableArea = 3000;
minAllowableArea = 100;
keeperBlobs = circularities < 4 & allAreas < maxAllowableArea & allAreas > minAllowableArea % Whatever values you want.
% Get actual index numbers instead of a logical vector
% so we can use ismember to extract those blob numbers.
roundObjects = find(keeperBlobs);

% Compute new binary image with only the small, round objects in it.
binaryImage = ismember(labeledImage, roundObjects) > 0;
%binaryImage = binaryImage.*faceMaskIm;
binaryImage = bwareafilt(logical(binaryImage),4);
imshow(binaryImage);
%binaryImage = bwareafilt(binaryImage,2);



%% Find circles in eye map image

%[centers, radii] = imfindcircles(binaryImage,[10 20],'ObjectPolarity','dark','Sensitivity',0.95)
[centersBright, radiiBright] = imfindcircles(binaryImage,[10 20],'ObjectPolarity','bright','Sensitivity',0.96);
figure; imshow(eyes);

eyeCandidates = [];
floor(centersBright(1, 1))

if(length(centersBright) < 2)
    test = -1;
    return;
end 

for n = 1:length(centersBright)
    x = mean(centersBright(n:length(centersBright),1));
    y = mean(centersBright(n:length(centersBright),2));
    
    eyeCandidates = [eyeCandidates; round([x y])];
end

eyeCenter = [];

for i = 1:length(eyeCandidates)
    for j = (i+1):length(eyeCandidates)
        d = abs(eyeCandidates(i, :) - eyeCandidates(j, :));
        dist = sqrt(d(1)^2+d(2)^2);
        point.p1 = eyeCandidates(i, :);
        point.p2 = eyeCandidates(j, :);
        point.d = d;
        point.dist = dist;
        
        eyeCenter = [eyeCenter point];
    end
end

rotationCenter = 0;

for i = 1:length(eyeCenter)
    n = faceMaskIm(eyeCenter(i).p1(2), eyeCenter(i).p1(1))
    if i == 1
        rotationCenter = eyeCenter(i);
    elseif rotationCenter.d(1) > eyeCenter(i).d(1) && eyeCenter(i).dist > 100
        rotationCenter = eyeCenter(i);
    end
end
        
l = rotationCenter.p1(1);
o = rotationCenter.p1(2);
imshow(eyeMapImage);hold on;plot(o,l,'r+', 'MarkerSize', 50);
hold on; plot(rotationCenter.p2(2), rotationCenter.p2(1), 'r+', 'MarkerSize', 50);

%% 
%i = faceMaskIm(floor(centersBright(10, 1)), floor(centersBright(10,2)))
% for k = 1 : length(centersBright);
%    %n = faceMaskIm(floor(centersBright(k, 1)), floor(centersBright(k,2)));
%    if(n == 1)
%       %plot(centroidX(k), centroidY(k), ...
%       %'ro', 'MarkerSize', 20, 'LineWidth', 2);
%       eyeCandidates = [eyeCandidates; [floor(centersBright(k, 1)), floor(centersBright(k,2))]];
%    end
% 
% end

%h = viscircles(eyeCandidates,radiiBright);
%hold on; figure; imshow(eyeMapImage); plot(eyeMapImage(eyeCenter.p1(1), eyeCenter.p1(2)), eyeMapImage(eyeCenter.p2(1), eyeCenter.p2(2)));

%%


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
% 
% for k = 1 : length(centroidX);
%    n = faceMaskIm(floor(centroidX(k)), floor(centroidY(k)));
%    if(n == 1)
%       plot(centroidX(k), centroidY(k), ...
%       'ro', 'MarkerSize', 20, 'LineWidth', 2);
%       eyeCandidates = [eyeCandidates; [floor(centroidX(k)), floor(centroidY(k))]];
%    end
% 
% end


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
% eyeCandidates = imfindcircles(binaryImage, 0.3);
% len = length(eyeCandidates);
% for K=1:1:len
%     hold on;
%     if (round(eyeCandidates(K,1)) <= dimH) && (round(eyeCandidates(K,2)) <= dimW)
%         if eyeMapImage(round(eyeCandidates(K,1)), round(eyeCandidates(K,2))) <= 0.8 
%                 plot(eyeCandidates(K,1), eyeCandidates(K,2), 'b*', 'MarkerSize', 5, 'LineWidth', 5);
%         end
%     end
% end
% 
% finalEyeMap = bwareafilt(logical(eyes),40);
%imshow(finalEyeMap);
test = eyeMapImage;
end

