% Authors: Josefine Klintberg & Martin Hag
% id: identification number for the person in the database, is 0 if no match exist.
% im: test image in color.
function id = tnm034(im) % 

%% Database preparations

% Read in all images from the database, store images as 1D vectors.
ImageVectors = CreateDatabase();

% Make the information needed for eigenface identity check.
[mean, A, Eigenfaces] = makeEigenface(ImageVectors);

%% Converting image into YCbCr and getting a face mask

YCBCRIm = rgb2ycbcr(im);
faceMaskIm = faceMask(im);
eyeMapIm = eyeMap(im, YCBCRIm, faceMaskIm); 



%% Test if the image is inside the database.

% Find the corresponding image. Returns 0 if no match found.
id = faceRecognition(im, mean, A, Eigenfaces);
