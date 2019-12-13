% A function to test see the eye points in a number of images at once.
function testFaceDetection()

DirPath = 'Images/DB1/'; % File Path
S = dir(fullfile(DirPath,'db1_*.jpg')); % Pattern to match filenames.

%% Read in all images inside the database
for k = 1:numel(S)
    
    % Read one image from database folder.
    F = fullfile(DirPath,S(k).name);
    im = imread(F);
    
    faceMaskIm = faceMask(im);
    eyeMapn = eyeMap(im, faceMaskIm);
    [P1, P2] = eyeDetect(eyeMapn, faceMaskIm);

    %Show original image from database.
    figure; imshow(im);
    
    % Show blue dots for eyes.
    if(P1 ~= -1)
    hold on;  plot(P1(1), P1(2), 'ro' ...
        ,'MarkerSize', 6, ...
        'MarkerEdgeColor', 'b', ...
        'MarkerFaceColor', 'b');

    hold on;  plot(P2(1), P2(2), 'ro' ...
        ,'MarkerSize', 6, ...
        'MarkerEdgeColor', 'b', ...
        'MarkerFaceColor', 'b');
    end
    
end
