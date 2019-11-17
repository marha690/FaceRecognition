function out = adjustImageValues(im)

if isa(im, 'uint8')|isa(im, 'uint16')
    im = im2double(im);
end

% Make image grayscale
im = rgb2gray(im);

out = im;