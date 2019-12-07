function result = combinedMask(eyeMapImage, faceMaskIm)

%% Make a mask from eyeMap and faceMask.
% figure; imshow(faceMaskIm);
% figure; imshow(eyeMapImage);


se1 = strel('disk', 10,8);
eyeMapBlur = imdilate(eyeMapImage, se1);

se2 = strel('disk', 10,8);
faceMaskIm = imerode(faceMaskIm, se2);



BW2 = eyeMapBlur.*faceMaskIm;
Max = max(BW2(:));
Min = min(BW2(:));
scaled = (BW2 - Min) ./ (Max - Min);

% figure; imshow(scaled);

% Final mask
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
res = im2bw(scaled, 0.6);
[rows, columns, numberOfColorChannels] = size(res);

halfMask = zeros(rows,columns);
halfMask(1:floor(rows/1.8),:) = 1; % 
halfMask(1:floor(rows*0.4),:) = 0; % Show things above the mouth
halfMask(:,1:floor(columns/4)) = 0; % Mask left side of image.
halfMask(:,floor(columns*3/4):columns) = 0; % Mask right side of image.

res2 = res.*halfMask;
res = im2bw(res2, 0.5);

 [rows, cols] = size(res);

 result = 255.*double(res)./max(max(double(res)));
