% mean_matrix: mean values saved in a 1D image vector
function [mean_matrix, x, Eigenfaces] = makeEigenface(inData)

[h,w,n] = size(inData);
d = h*w;
% Vectorize images
x = reshape(inData,[d n]);
x = double(x);
% Subtract mean
mean_matrix = mean(x,2);
x = bsxfun(@minus, x, mean_matrix);

% obtain eigenvalue & eigenvector
s =  x' * x; % Covariance, sort of
[V,D] = eig(s);
eigval = diag(D);

% Sort eigenvalues in descending order
eigval = eigval(end:-1:1);
V = fliplr(V);

Eigenfaces  = x * V;

