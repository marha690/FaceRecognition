function index = faceRecognition(InputImage, m, Weights, Eigenfaces)

ProjectedImages = [];
NumberImages = size(Eigenfaces,2);

% Extracting the PCA features from test image
tempImage = InputImage(:,:,1);

[w h] = size(tempImage);
[w2 h2] = size(m);

if(w ~= w2 & h ~= h2)
   index = 0;
   return;
end

Diff2Mean = double(tempImage) - m; %Subtracting the mean
newWeight = transpose(Eigenfaces)*Diff2Mean;

%% Take out the top five min dist and compare (fisherface, light version)

threshold = 9.3 * 10^8;

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


IDarray = [id1, id2, id3]
occurences = 1;
minDiff = 0;

if((id1 ~= id2 & id1 ~= id3 & id2 ~= id3) | (one < 10^3))
    [minDiff, index] = min(sum(sqrt((Weights-newWeight).^2))); % Find image with minimum euclidian distance
else %Some ids match, uncertainty around correct ID, check the most like person
    index = mode(IDarray);
    for(i = 1:3)
        if(i == 1)
            minDiff = theMinsSort(1);
        end
        if(IDarray(i) == index)
            occurences = occurences + 1
            minDiff = minDiff + theMinsSort(i)
        end
    end
%    minDiff = theMins(index);
end

minDiff = minDiff/occurences
%[minDiff, index] = min(sum(sqrt((A-newWeight).^2))); % Find image with minimum euclidian distance

% fprintf('Euclidian distance:');
% disp(index);
% disp(minDiff);

if (minDiff > threshold) % Setting threshold 
       index = 0;
       return;
 end
    


