% Author: Josefine Klintberg & Martin Hag
% Course: tnm034
% Date: 2019-11-17 to 2019-12-15

clear;
% Read in image to be tested.
Image = imread('images/DB0/db0_2.jpg'); %Not in db.
% Image = imread('images/DB1/db1_02.jpg'); %Inside db.

%Find face and prepare image to be tested.
Image2 = temporaryFaceFinderFunction(Image);

%Start face recognintion process.
value = tnm034(Image2);

% Show result to the user.
if(value == 0)
    fprintf('Match not foud.\n');
else 
    fprintf('Match foud.\n');
    fprintf('The person has ID:');
    disp(value);
end;

