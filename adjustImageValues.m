function out = adjustImageValues(im)

if isa(im, 'uint8')|isa(im, 'uint16')
    im = im2double(im);
end

% Check for light interferance.

%% Step 1: Check if top 5% of all pixels is more than a value(1000).
SortedPixelValues = reshape(im,[],size(im,3),1);
SortedPixelValues = sort(SortedPixelValues);

MaxPixelValue = max(SortedPixelValues(:)');




% Make image grayscale
im = rgb2gray(im);


out = im;