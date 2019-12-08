% mean_matrix: mean values saved in a 1D image vector
function [Mean, A, Eigenfaces] = makeEigenfaces(inData)

[h,w,n] = size(inData);
d = h*w;
% % Vectorize images
ims = reshape(inData,[d n]);
ims = double(ims);

% Create the mean face
Mean = mean(ims, 2);

% Subtract mean face from each face.
Diff2MeanFace = ims-Mean;

[eigenVectors,~] = eigs(transpose(Diff2MeanFace)*Diff2MeanFace, 16);
Eigenfaces = Diff2MeanFace*eigenVectors;

% Calculate the weights
A = transpose(Eigenfaces)*Diff2MeanFace;
