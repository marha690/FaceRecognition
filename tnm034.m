% Authors: Josefine Klintberg & Martin Hag

% im: Image of unknown face, RGB-image in uint8 format in the ? % range [0,255] %
% id: The  The identity number (integer) of the identified person,? 
% i.e. ‘1’, ‘2’,…,‘16’ for the persons belonging to ‘db1’ and ‘0’ for all other faces. % 
function id = tnm034(im) % 

% Read in all images -> will be turned into loading of database
DirPath = 'Images/DB1/';
S = dir(fullfile(DirPath,'db1_*.jpg')); % pattern to match filenames.
for k = 1:numel(S)
    F = fullfile(DirPath,S(k).name);
    I = imread(F);
    % My code to store a image in a column.
    I = rgb2gray(I);
    I = I(1:300,1:350);
%     I = I(:);
    Images(:,:,k) = I(:,:); % save images.
%     Images(:,k) = I(:)'; % save images.
end


% all images of the training set are stored in a single matrix T, 
% where each column of the matrix is an image.
test = makeEigenface(Images);

%% Finding the face in an image

face = faceDetection(im);
imshow(face);

%%
% Rotates the image.
im = faceRotation(im);


% Give id the correct value.
id = 2;
