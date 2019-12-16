function T = loadImages()
% Loads images and process them, from files into a database
% T = Image vectors from the database. 
% Columns in T: Each image in a 1D vecor format.
% Rows in T: Number of images in the database.

% TODO: Make a function to replace the loops

%% Read in images in DB1

DirPath = 'Images/DB1/'; % File Path
S = dir(fullfile(DirPath,'db1_*.jpg')); % Pattern to match filenames.

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

%% Read in additional facial expressions
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

%% Read in images with blured faces
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


%% Read in images with clustered backgrounds 
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

%% Additional photos to expand number of images per person
DlDirPath = 'Images/NewDb/map1'; % File Path
DlS = dir(fullfile(DlDirPath,'_*.jpg')); % Pattern to match filenames.
DBSize = DBSize + numel(ClS);
for k = 1:numel(DlS)
    
    % Read one image from database folder.
    F = fullfile(DlDirPath,DlS(k).name);
    Name = DlS(k).name;
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

DlDirPath = 'Images/NewDb/map2'; % File Path
ElS = dir(fullfile(DlDirPath,'_*.jpg')); % Pattern to match filenames.
DBSize = DBSize + numel(DlS);
for k = 1:numel(ElS)
    
    % Read one image from database folder.
    F = fullfile(DlDirPath,ElS(k).name);
    Name = ElS(k).name;
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

DlDirPath = 'Images/NewDb/map3'; % File Path
FlS = dir(fullfile(DlDirPath,'_*.jpg')); % Pattern to match filenames.
DBSize = DBSize + numel(ElS);
for k = 1:numel(FlS)
    
    % Read one image from database folder.
    F = fullfile(DlDirPath,FlS(k).name);
    Name = FlS(k).name;
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

DlDirPath = 'Images/NewDb/map4'; % File Path
GlS = dir(fullfile(DlDirPath,'_*.jpg')); % Pattern to match filenames.
DBSize = DBSize + numel(FlS);
for k = 1:numel(GlS)
    
    % Read one image from database folder.
    F = fullfile(DlDirPath,GlS(k).name);
    Name = GlS(k).name;
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
