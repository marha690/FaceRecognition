% Author: Josefine Klintberg & Martin Hag
% Course: tnm034
% Date: 2019-11-17 to 2019-12-15

clear;
%Read in variables.
Image = imread('images/DB1/db1_04.jpg');
%imshow(Image);
Image2 = lightCorrection(Image);
%figure; imshow(Image2); figure;
%Start face recognintion process.
value = tnm034(Image2);

%Show result.
