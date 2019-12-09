% T = Image vectors from the database. 
% Columns in T: Each image in a 1D vecor format.
% Rows in T: Number of images in the database.
function T = loadImages()

DirPath = 'Images/DB1/'; % File Path
S = dir(fullfile(DirPath,'db1_*.jpg')); % Pattern to match filenames.

% Add if file not found (db2), continue

%% Read in all images inside the database
for k = 1:numel(S)
    
    % Read one image from database folder.
    F = fullfile(DirPath,S(k).name);
    I = imread(F);
    
    %Prepare the image.
    I = imageModifications(I);
    
    % Could find the face
    if(I ~= -1)
            T(:,:,k) = I(:,:); 
    end

end

% Expressions
ExDirPath = 'Images/DB2/'; % File Path
ExS = dir(fullfile(ExDirPath,'ex_*.jpg')); % Pattern to match filenames.
DBSize = numel(S);
for k = 1:numel(ExS)
    
    % Read one image from database folder.
    F = fullfile(ExDirPath,ExS(k).name);
    Name = ExS(k).name;
    Num = regexp(Name,'\d');
    Number = Name(Num(1): Num(end));
    Number = str2num(Number);

    I = imread(F);
    
    %Prepare the image.
    I = imageModifications(I);
    
    % Could find the face
    if(I ~= -1)
            T(:,:,DBSize + Number) = I(:,:); 
    end

end

% Blured faces
BlDirPath = 'Images/DB2/'; % File Path
BlS = dir(fullfile(BlDirPath,'bl_*.jpg')); % Pattern to match filenames.
DBSize = DBSize + numel(ExS);
for k = 1:numel(BlS)
    
    % Read one image from database folder.
    F = fullfile(BlDirPath,BlS(k).name);
    Name = BlS(k).name;
    Num = regexp(Name,'\d');
    Number = Name(Num(1): Num(end));
    Number = str2num(Number);
    
    I = imread(F);
    
    %Prepare the image.
    I = imageModifications(I);
    
    % Could find the face
    if(I ~= -1)
            T(:,:,DBSize + Number) = I(:,:); 
    end

end


% Clustred faces
ClDirPath = 'Images/DB2/'; % File Path
ClS = dir(fullfile(BlDirPath,'cl_*.jpg')); % Pattern to match filenames.
DBSize = DBSize + numel(BlS);
for k = 1:numel(ClS)
    
    % Read one image from database folder.
    F = fullfile(ClDirPath,ClS(k).name);
    Name = ClS(k).name;
    Num = regexp(Name,'\d');
    Number = Name(Num(1): Num(end));
    Number = str2num(Number);

    I = imread(F);
    
    %Prepare the image.
    I = imageModifications(I);
    
    % Could find the face
    if(I ~= -1)
            T(:,:,DBSize + Number) = I(:,:); 
    end

end


% Illuminance faces
IlDirPath = 'Images/DB2/'; % File Path
IlS = dir(fullfile(IlDirPath,'il_*.jpg')); % Pattern to match filenames.
DBSize = DBSize + numel(ClS);
for k = 1:numel(IlS)
    
    % Read one image from database folder.
    F = fullfile(IlDirPath,IlS(k).name);
    Name = IlS(k).name;
    Num = regexp(Name,'\d');
    Number = Name(Num(1): Num(end));
    Number = str2num(Number);

    I = imread(F);
    
    %Prepare the image.
    I = imageModifications(I);
    %T = size(I);
    
    % Could find the face
    if(I ~= -1)
            T(:,:,DBSize + Number) = I(:,:); 
    end

end