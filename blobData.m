function [NumOfBlobs, BlobsPos] = blobData(binaryImage)
%% Find areas inside a binary image and returns their mean positions
% NumOfBlobs: Number of found blobs
% BlobsPos: Array of 20 vectors where the mean position for the blobs are
% stored

%% Find blobs

[LabelImage, NumOfBlobs] = bwlabel(binaryImage,4);
BlobSize = (NumOfBlobs);
UnsortedBlobsPos = zeros(NumOfBlobs, 2);
for i = 1:NumOfBlobs
    
    [rows, columns] = find(LabelImage == i);
    rc = [rows columns];
    
    %keep track of size for each blob.
    PixelsInBlob = size(rows);
    BlobSize(i) = PixelsInBlob(1,1);
    
    % Find the middle point of the blob.
    UnsortedBlobsPos(i,:) = mean(rc);
end

%% Sort the array depending on size. Largest to smallest.

BlobsPos = zeros(NumOfBlobs, 2);
[~, Indexes] = sort(BlobSize);
for i = 1:NumOfBlobs
    
    Index = find(Indexes == i);
    BlobsPos(NumOfBlobs + 1 - i,:) = UnsortedBlobsPos(Index,:);
end

