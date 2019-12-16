function [Mean, Weights, Eigenfaces] = makeEigenfaces(Images)
% Creates eigenface representation from input data
% Mean: mean values saved in a 1D image vector
% Weights: weights for eigenfaces
% Eigenfaces: eigenvectors for corresponding face
% The input, Images, need to be grayscale images

[h,w,n] = size(Images);
d = h*w;

%% Vectorize images
ims = reshape(Images,[d n]);
ims = double(ims);

% Create the mean face
Mean = mean(ims, 2);

% Subtract mean face from each face.
Diff2MeanFace = ims-Mean;

[eigenVectors,~] = eigs(transpose(Diff2MeanFace)*Diff2MeanFace, 16);
Eigenfaces = Diff2MeanFace*eigenVectors;

%% Calculate the weights

Weights = transpose(Eigenfaces)*Diff2MeanFace;
