function result = combinedMask(eyeMapImage, faceMaskIm)

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

% Make parts of the image black.
[rows, columns, numberOfColorChannels] = size(res);
halfMask = zeros(rows,columns);
halfMask(1:floor(rows/1.5),:) = 1; % Show things above the mouth
halfMask(:,1:floor(columns/4)) = 0; % Mask left side of image.
halfMask(:,floor(columns*3/4):columns) = 0; % Mask right side of image.

result = im2bw((res.*halfMask), 0.5);