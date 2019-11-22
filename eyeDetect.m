function output = eyeDetect(eyeMapImage, faceMask)
%EYEDETECT From an eye map, this function detects the eyes and calculate
%the distance between them 
%I = rgb2gray(image)
BW = edge(eyeMapImage,'prewitt');
[H,T,R] = hough(BW,'RhoResolution',0.5,'Theta',-90:0.5:89);

eyes = BW.*eyeMapImage.*faceMask;
imshow(eyes);

maxValue = max(eyeMapImage(:));
[rowsOfMaxes colsOfMaxes] = find(eyeMapImage == maxValue)

trueEyes = zeros(0);
[dimH, dimW] = size(eyeMapImage);

eyeCandidates = imfindcircles(BW, 0.5);
len = length(eyeCandidates);
for K=1:1:len
    hold on;
    if (round(eyeCandidates(K,1)) <= dimH) && (round(eyeCandidates(K,2)) <= dimW)
        if eyeMapImage(round(eyeCandidates(K,1)), round(eyeCandidates(K,2))) <= 0.9
                plot(eyeCandidates(K,1), eyeCandidates(K,2), 'b*', 'MarkerSize', 5, 'LineWidth', 5);
        end
    end
end



output = eyeMapImage;
end

