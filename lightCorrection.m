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

R=double(inputImage(:,:,1));
G=double(inputImage(:,:,2));
B=double(inputImage(:,:,3));
[H,W]=size(R);

[srow,scol]=find(R==0 & G==0 & B==0);
% if(isempty(srow) && isempty(scol))
    minR=min(min(R));
    minG=min(min(G));
    minB=min(min(B));
% end

R=R-minR;
G=G-minG;
B=B-minB;

S=zeros(H,W);
[srow,scol]=find(R==0 & G==0 & B==0);
[sm,sn]=size(srow);

for i=1:sm
     S(srow(i),scol(i))=1;
end
mstd=sum(sum(S));
Nstd=(H*W)-mstd;

Cst=0;
Cst=double(Cst);
for i=1:H
    for j=1:W
         a=R(i,j);
         b=R(i,j);
         
            if(B(i,j)<a)
               a=B(i,j);
            else
               b=B(i,j);
            end
         
             if(G(i,j)<a)
                a=G(i,j);
             else
                b=G(i,j);
             end
         
         Cst=a+b+Cst;
         
    end
end
%%%%sum of black pixels%%%%%%%%%%%
blacksumR=0;
blacksumG=0;
blacksumB=0;
for i=1:sm
    blacksumR=blacksumR+R(srow(i),scol(i));
    blacksumG=blacksumG+G(srow(i),scol(i));
    blacksumB=blacksumR+B(srow(i),scol(i));
end
Cstd = Cst/(2*Nstd);
CavgR=sum(sum(R))./(H*W);
CavgB=sum(sum(B))./(H*W);
CavgG=sum(sum(G))./(H*W);
Rsc=Cstd./CavgR;
Gsc=Cstd./CavgG;
Bsc=Cstd/CavgB;

R=R.*Rsc;
G=G.*Gsc;
B=B.*Bsc;

C(:,:,1)=R;
C(:,:,2)=G;
C(:,:,3)=B;
C=C/255;
YCbCr=rgb2ycbcr(C);
Y=YCbCr(:,:,1);


%normalize Y
minY=min(min(Y));
maxY=max(max(Y));
Y=255.0*(Y-minY)./(maxY-minY);
YEye=Y;
Yavg=sum(sum(Y))/(W*H);

T=1;
if (Yavg<90)
    T=1.4;
elseif (Yavg>170)
    T=0.6;
end

if (T~=1)
    RI=R.^T;
    GI=G.^T;
else
    RI=R;
    GI=G;
end


Cfinal(:,:,1)=uint8(RI);
Cfinal(:,:,2)=uint8(GI);
Cfinal(:,:,3)=uint8(B);
lightCorrectedIm = Cfinal;


% R = inputImage(:,:,1);
% G = inputImage(:,:,2);
% B = inputImage(:,:,3);
% 
% RscalVal=sum(sum(R))/numel(R);
% GscalVal=sum(sum(G))/numel(G);
% BscalVal=sum(sum(B))/numel(B);
%     
% R = R*(127.5/RscalVal);
% G = G*(127.5/GscalVal);
% B = B*(127.5/BscalVal);
%     
% lightCorrectedIm = cat(3,R,G,B);
end

