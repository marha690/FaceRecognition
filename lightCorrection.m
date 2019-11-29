function lightCorrectedIm = lightCorrection(inputImage)
%Light correction, checks if the lightning in the image is 
%sufficient. If not, perform grayworld compensation.

SortedPixelValues = reshape(inputImage,[],size(inputImage,3),1);
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
    lightCorrectedIm = inputImage;
    %fprintf('No Color adjustment was done. \n');
    return
end

%% Step 3: Color correction, Gray world compensation

R = inputImage(:,:,1);
G = inputImage(:,:,2);
B = inputImage(:,:,3);

RscalVal=sum(sum(R))/numel(R);
GscalVal=sum(sum(G))/numel(G);
BscalVal=sum(sum(B))/numel(B);
    
R = R*(127.5/RscalVal);
G = G*(127.5/GscalVal);
B = B*(127.5/BscalVal);
    
lightCorrectedIm = cat(3,R,G,B);
end

