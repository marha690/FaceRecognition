function index = faceRecognition(InputImage, m, A, Eigenfaces)

ProjectedImages = [];
NumberImages = size(Eigenfaces,2);
for i = 1 : NumberImages
    temp = Eigenfaces'*A(:,i); % Projection of centered images into facespace
    ProjectedImages = [ProjectedImages temp]; 
end


% Extracting the PCA features from test image
tempImage = InputImage(:,:,1);

[irow icol] = size(tempImage);
InImage = reshape(tempImage',irow*icol,1);
Difference = double(InImage)-m; % Centered test image
ProjectedTestImage = Eigenfaces'*Difference; % Test image feature vector

% Calculating Euclidean distances 
EucDist = [];
for i = 1 : NumberImages
    q = ProjectedImages(:,i);
    temp = ( norm( ProjectedTestImage - q ) )^2;
    EucDist = [EucDist temp];
end

[EucDistMin , index] = min(EucDist);

threshold = 1.3e16;
if( EucDistMin >= threshold)
    index = 0;
end
fprintf('Euclidian distance:');
disp(EucDistMin);
