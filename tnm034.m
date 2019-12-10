% Authors: Josefine Klintberg & Martin Hag
% id: identification number for the person in the database, is 0 if no match exist.
% im: Modified test image. Gray scale and same size as them in DBVariables.
function id = tnm034(im) % 

load('DBVariables');

imVector = im(:);

% Find the corresponding image. Returns 0 if no match found.
% id = faceRecognition(imVector, Mean, A, Eigenfaces);

index = faceRecognition(imVector, Mean, A, Eigenfaces);

%Match not found
if(index == 0)
    id = 0;
    return;
end

id = mod(index, 16);
if(id == 0)
    id = 16;
end
