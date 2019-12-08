% Author: Josefine Klintberg & Martin Hag
% Course: tnm034
% Date: 2019-11-17 to 2019-12-15

%% Create Database.

% Read in all images from the database, store images as 1D vectors.
ImageVectors = loadImages();

% Save the information needed for eigenface identity check.
[Mean, A, Eigenfaces] = makeEigenfaces(ImageVectors);
save('DBVariables','Mean', 'A', 'Eigenfaces');
disp('Saved database');

%% Start face recognintion process.

% Read in image to be tested.
% Image = imread('images/DB0/db0_1.jpg'); %Not in db.
% Image = imread('images/DB1/db1_11.jpg'); %Inside db.
% Image = imread('images/DB2/il_16.jpg'); %Inside db.
% Image = imread('images/rotated/db1_06.jpg'); %Inside db.
 Image = imread('images/DB1/comb/db1_06.jpg'); %Inside db.

PreparedImage = imageModifications(Image);
%Prep = rgb2gray(PreparedImage);
%figure; imshow(Prep);
value = tnm034(PreparedImage);

% Show result to the user.
if(value == 0)
    fprintf('Match not found.\n');
else 
    fprintf('Match found.\n');
    fprintf('The person has ID:');
    disp(value);
end;