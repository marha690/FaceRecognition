%% Make eyeMap and faceMask into one mask for eyes.
function result = combinedMask(eyeMapImage, faceMaskIm)

% Blur the eye map
se1 = strel('disk', 10,8);
eyeMapBlur = imdilate(eyeMapImage, se1);

% Remove edges from face mask
se2 = strel('disk', 10,8);
faceMaskIm = imerode(faceMaskIm, se2);

% Normalize the colors between 0 and 1
BW2 = eyeMapBlur.*faceMaskIm;
Max = max(BW2(:));
Min = min(BW2(:));
scaled = (BW2 - Min) ./ (Max - Min);


Mask = im2bw(scaled, 0.6);
[rows, columns, ~] = size(Mask);

% Masks for edges in the image
EdgeMask = zeros(rows,columns);
EdgeMask(1:floor(rows/1.8),:) = 1; % show everything exept the bottom part.
EdgeMask(1:floor(rows*0.4),:) = 0; % mask top of the image.
EdgeMask(:,1:floor(columns/4)) = 0; % Mask left side of image.
EdgeMask(:,floor(columns*3/4):columns) = 0; % Mask right side of image.
Mask = Mask.*EdgeMask;

BinaryResult = im2bw(Mask, 0.5);
result = 255.*double(BinaryResult)./max(max(double(BinaryResult)));
