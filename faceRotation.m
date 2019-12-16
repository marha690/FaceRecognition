function out = faceRotation(im, P1, P2)
% Rotates image according to two eye points, P1 and P2 
% Eyes becomes horizontal after rotation
% Im: image
% out: rotated image.
% P1 is the eye left on the screen compared to eye P2.

%% Calculate angle to rotate
P0 = [P1(1)+20 P1(2)];
n1 = (P2 - P1) / norm(P2 - P1);
n2 = (P0 - P1) / norm(P0 - P1);

angle = acos(dot(n1, n2));    
degAngle = radtodeg(angle);

%% Make sign of rotation correct
if( P1(2) > P2(2) )
    degAngle = degAngle * -1;
end

%% Rotates in degrees.
out = imrotate(im,degAngle,'bilinear','crop');