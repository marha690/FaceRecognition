function out = adjustImageValues(im)

original = im;

if isa(im, 'uint8')||isa(im, 'uint16')
    im = im2double(im);
end

% Check for light interferance.

%% Step 1: Get top 5% pixels average red, greed and blue.
SortedPixelValues = reshape(im,[],size(im,3),1);
SortedPixelValues = sort(SortedPixelValues);

NumOfPixels = size(SortedPixelValues,1);
MaxPixelValue = SortedPixelValues(NumOfPixels,:);

%Find the scalar number of the N's pixel from max.
Top5Percent = NumOfPixels - floor(NumOfPixels*0.05);
TopPixels = SortedPixelValues(Top5Percent:NumOfPixels,:);

%Get average valeus for red, green and blue channel.
AR = mean(TopPixels(:,1));
AG = mean(TopPixels(:,2));
AB = mean(TopPixels(:,3));

%% Step 2: Test is there is interferance in color
Value = max(max(AR,AG),AB) / min(min(AR,AG),AB);
Acceptance = 0.01;

if ( abs(1-Value) < Acceptance )
    out = original;
    fprintf('No Color adjustment was done. \n');
    return
end

%% Color adjustment.
avgR = mean(SortedPixelValues(:,1));
avgG = mean(SortedPixelValues(:,2));
avgB = mean(SortedPixelValues(:,3));
avgGray = (avgR+avgG+avgB)/3;

aR = avgGray/avgR;
aG = avgGray/avgG;
aB = avgGray/avgB;

im(:,:,1) = im(:,:,1) * aR;
im(:,:,2) = im(:,:,2) * aG;
im(:,:,3) = im(:,:,3) * aB;

% Dont allow value over 1 inside the image.
for x = 1:size(im,1)
    for y = 1:size(im,2)
        for rgb = [1 2 3]
            if(im(x,y,rgb) > 1)
                im(x,y,rgb) = 1;
            end
        end
    end
end

out = im;
imshow(out); figure;
