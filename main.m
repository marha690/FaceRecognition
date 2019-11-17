% Author: Josefine Klintberg & Martin Hag
% Course: tnm034
% Date: 2019-11-17 to 2019-12-15

clear;
%Read in variables.
Image = imread('images/DB0/db0_1.jpg');

%Start face recognintion process.
value = tnm034(Image);

%Show result.
