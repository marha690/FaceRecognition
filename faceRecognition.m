function index = faceRecognition(InputImage, Mean, Weights, Eigenfaces)
% Compares the input image to known faces in database

%% Thresholds

threshold = 9.3 * 10^8;
thresholdLow = 10^3;

%% PCA

ProjectedImages = [];
NumberImages = size(Eigenfaces,2);

% Extracting the PCA features from test image
tempImage = InputImage(:,:,1);

[w h] = size(tempImage);
[w2 h2] = size(Mean);

% Check image dimensions, if error occured, return
if(w ~= w2 & h ~= h2)
   index = 0;
   return;
end

Diff2Mean = double(tempImage) - Mean; %Subtracting the mean
newWeight = transpose(Eigenfaces)*Diff2Mean;

%% Take out the top three min dist and compare (fisherface, light version)

theMins = sum(sqrt((Weights-newWeight).^2));
theMinsSort = sort(theMins);
one = theMinsSort(1);
id1 = find(theMins == one); id1 = mod(id1, 16);
two = theMinsSort(2);
id2 = find(theMins == two); id2 = mod(id2, 16);
three = theMinsSort(3);
id3 = find(theMins == three); id3 = mod(id3, 16);

if(length(id1) ~= 1 & length(id2) ~= 1 & length(id3) ~= 1)
    index = 0;
    return;
end

if(id1 == 0)
    id1 = 16;
end
if(id2 == 0)
    id2 = 16;
end
if(id3 == 0)
    id3 = 16;
end

IDarray = [id1, id2, id3];
occurences = 1;
minDiff = 0;


if((id1 ~= id2 & id1 ~= id3 & id2 ~= id3) | (one < thresholdLow)) % If equally alike all 3 min, or extremely alike the top one
    [minDiff, index] = min(sum(sqrt((Weights-newWeight).^2))); % Find image with minimum euclidian distance
else %Some ids match, uncertainty around correct ID, check the most likely person and compute mean euclidian distance
    index = mode(IDarray);
    for(i = 1:3)
        if(i == 1)
            minDiff = theMinsSort(1);
        end
        if(IDarray(i) == index)
            occurences = occurences + 1;
            minDiff = minDiff + theMinsSort(i);
        end
    end
end

minDiff = minDiff/occurences;

%fprintf('Euclidian distance:');
%disp(index);
%disp(minDiff);

if (minDiff > threshold) % Check if close enough to decide match
       index = 0;
       return;
 end
  
