function index = faceRecognition(InputImage, m, A, Eigenfaces)

ProjectedImages = [];
NumberImages = size(Eigenfaces,2);

% Extracting the PCA features from test image
tempImage = InputImage(:,:,1);

[w h] = size(tempImage);
[w2 h2] = size(m);

if(w ~= w2 | h ~= h2)
   index = 0;
   return;
end

Diff2Mean = double(tempImage) - m; %Subtracting the mean
newWeight = transpose(Eigenfaces)*Diff2Mean;

[minDiff, index] = min(sum(sqrt((A-newWeight).^2))); % Find image with minimum euclidian distance

fprintf('Euclidian distance:');
disp(minDiff);

if minDiff > 4 * 10^8 % Setting threshold 
       index = 0;
       return;
 end
    


