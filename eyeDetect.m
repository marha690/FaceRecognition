function output = eyeDetect(eyeMapImage, faceMask)
%EYEDETECT From an eye map, this function detects the eyes and calculate
%the distance between them 
%I = rgb2gray(image)
BW = edge(eyeMapImage,'prewitt');
[H,T,R] = hough(BW,'RhoResolution',0.5,'Theta',-90:0.5:89);


eyes = BW.*eyeMapImage.*faceMask;
imshow(eyes);

eyeCandidates = imfindcircles(BW, 1);
len = length(eyeCandidates);
for K=1:1:len
    hold on;
    plot(eyeCandidates(K,1), eyeCandidates(K,2), 'r+', 'MarkerSize', 5, 'LineWidth', 3);
end

output = eyeMapImage;
end

