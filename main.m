% Author: Josefine Klintberg & Martin Hag
% Course: tnm034
% Date: 2019-11-17 to 2019-12-15

clear;
%Read in image to be tested.
Image = imread('images/DB0/db0_1.jpg'); %Not in db.

%Find face and prepare image to be tested.
Image = temporaryFaceFinderFunction(Image);
% Image = Image(1:300,1:350); %Crop!

%Start face recognintion process.
value = tnm034(Image);

% Show result to the user.
if(value == 0)
    fprintf('Match not foud.\n');
else 
    fprintf('Match foud.\n');
    fprintf('The person has ID:');
    disp(value);
end;

