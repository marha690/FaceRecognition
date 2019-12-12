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
% Image = imread('Images/DB0/db0_4.jpg'); %Not in db.
% Image = imread('Images/DB1/db1_08.jpg'); %Inside db.
Image = imread('Images/DB2/il_07.jpg'); %Inside db.
% Image = imread('Images/rotated/db1_03.jpg'); %Inside db.
%  Image = imread('Images/DB1/comb/db1_16rotscale.jpg'); %Inside db.

PreparedImage = imageModifications(Image);
%t = imadjust(Image,[],[],2);
%t = lin2rgb(t);
t = imadjust(Image, [.1 .1 0; .6 .8 1],[]); %Im 1 and 2
%t = lightCorrection(t);
%t = rgb2gray(t);
figure; imshow(t);
%Prep = rgb2gray(PreparedImage);
%figure; imshow(Prep);
prep = imageModifications(t);
value = tnm034(prep);
%value = tnm034(PreparedImage);

% Show result to the user.
if(value == 0)
    fprintf('Match not found.\n');
else 
    fprintf('Match found.\n');
    fprintf('The person has ID:');
    disp(value);
end;