function result = combinedMask(eyeMapImage, faceMaskIm)

%% Make a mask from eyeMap and faceMask.

se1 = strel('disk', 10,8);
eyeMapBlur = imdilate(eyeMapImage, se1);

se2 = strel('disk', 10,8);
faceMaskIm = imerode(faceMaskIm, se2);

BW2 = eyeMapBlur.*faceMaskIm;
Max = max(BW2(:));
Min = min(BW2(:));
scaled = (BW2 - Min) ./ (Max - Min);

%% Final mask calculations
Mask = im2bw(scaled, 0.6);
[rows, columns, ~] = size(Mask);

halfMask = zeros(rows,columns);
halfMask(1:floor(rows/1.8),:) = 1; % Display all but bottom
halfMask(1:floor(rows*0.4),:) = 0; % Mask out top 
halfMask(:,1:floor(columns/4)) = 0; % Mask left side of image
halfMask(:,floor(columns*3/4):columns) = 0; % Mask right side of image

Mask2 = Mask.*halfMask;
Mask = im2bw(Mask2, 0.5);

result = 255.*double(Mask)./max(max(double(Mask)));
