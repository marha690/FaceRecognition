% function result = imageModifications(im)
% 
%     ImageHeight = 320;
%     ImageWidth = 220;
%     PixelsBetweenEyes = 100; % Approximative
%     result = -1;
%     
%     %% Gray world lighting compensation
% %     im = lightCorrection(im);
% 
%     %% Rotates the image.
%     faceMaskIm = faceMask(im);
%     eyeMapn = eyeMap(im, faceMaskIm);
%     [P1, P2] = eyeDetect(eyeMapn, faceMaskIm);
%     if(P1 == -1)
%        return;
%     end
%     rotIm = faceRotation(im, P1, P2);
%     rotMask = faceRotation(faceMaskIm, P1, P2);
%     rotEye  = faceRotation(eyeMapn, P1, P2);
% %     figure; imshow(rotIm);
% %             hold on;  plot(P1(1), P1(2), 'ro' ...
% %         ,'MarkerSize', 6, ...
% %         'MarkerEdgeColor', 'r', ...
% %         'MarkerFaceColor', 'r');
% %     hold on;  plot(P2(1), P2(2), 'ro' ...
% %         ,'MarkerSize', 6, ...
% %         'MarkerEdgeColor', 'r', ...
% %         'MarkerFaceColor', 'r');
%     %% Scale image
% 
%     [P1, P2] = eyeDetect(rotEye, rotMask);
%     if(P1 == -1)
%        return;
%     end
%     scaledIm = scaleImage(rotIm, P1, P2, PixelsBetweenEyes);
%     rotMask2 = scaleImage(rotMask, P1, P2, PixelsBetweenEyes);
%     rotEye2 = scaleImage(rotEye, P1, P2, PixelsBetweenEyes);
%     
%     
%     %% Crop Image
%     [P1, P2] = eyeDetect(rotEye2, rotMask2);
%     
% %     figure; imshow(scaledIm);
% %             hold on;  plot(P1(1), P1(2), 'ro' ...
% %         ,'MarkerSize', 6, ...
% %         'MarkerEdgeColor', 'r', ...
% %         'MarkerFaceColor', 'r');
% %     hold on;  plot(P2(1), P2(2), 'ro' ...
% %         ,'MarkerSize', 6, ...
% %         'MarkerEdgeColor', 'r', ...
% %         'MarkerFaceColor', 'r');
%     
%     if(P1 == -1)
%        return;
%     end
%     mid = [P1(1)+floor(PixelsBetweenEyes/2) P1(2)]; % position between eyes.
%     cropIm = cropImage(scaledIm, mid, ImageHeight, ImageWidth);
%     rotMask3 = scaleImage(rotMask2, P1, P2, PixelsBetweenEyes);
%     rotEye3 = scaleImage(rotEye2, P1, P2, PixelsBetweenEyes);
%     
%     [resW, resH, ~] = size(cropIm);
%     if(abs(resW - ImageHeight) > 2 || abs(resH - ImageWidth) > 2)
%         return;
%     else
%         result = lightCorrection(cropIm);
%         %result = imsharpen(result,'Radius',2,'Amount',1);
%         figure; imshow(result);
%     end
%     
% 
%     %%
% 
%  

function result = imageModifications(im)

    ImageHeight = 320;
    ImageWidth = 220;
    PixelsBetweenEyes = 100; % Approximative
    result = -1;

    %% Rotates the image.
    faceMaskIm = faceMask(im);
    figure; imshow(faceMaskIm);
    eyeMapn = eyeMap(im, faceMaskIm);
    [P1, P2] = eyeDetect(eyeMapn, faceMaskIm, im);
    if(P1 == -1)
       return;
    end
    rotIm = faceRotation(im, P1, P2);
    rotMask = faceRotation(faceMaskIm, P1, P2);
    rotEye  = faceRotation(eyeMapn, P1, P2);

    %% Scale image

    [P1, P2] = eyeDetect(rotEye, rotMask, rotIm);
    if(P1 == -1)
       return;
    end
    scaledIm = scaleImage(rotIm, P1, P2, PixelsBetweenEyes);
    scaleMask = scaleImage(rotMask, P1, P2, PixelsBetweenEyes);
    scaleEye = scaleImage(rotEye, P1, P2, PixelsBetweenEyes);
    
    %% Crop Image
    [P1, P2] = eyeDetect(scaleEye, scaleMask, scaledIm); 
    if(P1 == -1)
       return;
    end
    mid = [P1(1)+floor(PixelsBetweenEyes/2) P1(2)]; % position between eyes.
    cropIm = cropImage(scaledIm, mid, ImageHeight, ImageWidth);
%     cropMask = cropImage(scaleMask, P1, P2, PixelsBetweenEyes);
%     cropEye = cropImage(scaleEye, P1, P2, PixelsBetweenEyes);
    
    [resR, resC, ~] = size(cropIm);
    
    if ( abs(resR - ImageHeight) > 2 || abs(resC - ImageWidth) > 2)
       return; 
    end

    %%
    result = lightCorrection(cropIm);
 	result = imsharpen(result,'Radius',2,'Amount',1);
    
    figure; imshow(result);
 

