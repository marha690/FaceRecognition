% Authors: Josefine Klintberg & Martin Hag
% id: identification number for the person in the database, is 0 if no match exist.
% im: image to be tested if a match with a person the database sxists.
function id = tnm034(im) % 

%t = imadjust(Image,[],[],2);
%t = lin2rgb(t);

t = imadjust(im, [.1 .1 0; .6 .8 1],[]); %Im 1 and 2 % Test if needed??
%t = lightCorrection(t);
%t = rgb2gray(t);
%Prep = rgb2gray(PreparedImage);
%figure; imshow(Prep);
im = imageModifications(t);
load('DBVariables');

% Convert image to an 1D vector.
imVector = im(:);

% Find the corresponding image. Returns 0 if no match found.
index = faceRecognition(imVector, Mean, Weights, Eigenfaces);

% Match not found
if(index == 0)
    id = 0;
    return;
end

% Hash-function to convert index in array to the persons id.
id = mod(index, 16);
if(id == 0)
    id = 16;
end
