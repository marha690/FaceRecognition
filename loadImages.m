% T = Image vectors from the database. 
% Columns in T: Each image in a 1D vecor format.
% Rows in T: Number of images in the database.
function T = loadImages()

DirPath = 'Images/DB1/'; % File Path
S = dir(fullfile(DirPath,'db1_*.jpg')); % Pattern to match filenames.

%% Read in all images inside the database
for k = 1:numel(S)
    
    % Read one image from database folder.
    F = fullfile(DirPath,S(k).name);
    I = imread(F);
    
    %Prepare the image.
    I = imageModifications(I);
    
    % Could not find the face
    if(I ~= -1)
            T(:,:,k) = I(:,:); 
    end

end