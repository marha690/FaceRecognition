function index = faceRecognition(InputImage, m, A, Eigenfaces)

ProjectedImages = [];
Train_Number = size(Eigenfaces,2);
for i = 1 : Train_Number
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
for i = 1 : Train_Number
    q = ProjectedImages(:,i);
    temp = ( norm( ProjectedTestImage - q ) )^2;
    EucDist = [EucDist temp];
end

[EucDistMin , index] = min(EucDist);

threshold = 5000000;
if( EucDistMin >= threshold)
    index = 0;
end
fprintf('Euclidian distance:');
disp(EucDistMin);
