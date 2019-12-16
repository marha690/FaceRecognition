% Authors: Josefine Klintberg & Martin Hag
% id: identification number for the person in the database, is 0 if no match exist.
% im: Modified test image. Gray scale and same size as them in DBVariables.
function id = tnm034(im) % 

load('DBVariables');

im = imageModifications(im);

imVector = im(:); %Convert image to vector, 1D

%%  Find the corresponding image
index = faceRecognition(imVector, Mean, Weights, Eigenfaces);

%% Check if match not found
if(index == 0)
    id = 0;
    return;
end

%% Hash function, turn index into corresponding id

id = mod(index, 16);
if(id == 0)
    id = 16;
end
