function [J] = amplification(I, percent)
% applification- amplify main objects in image
%
% INPUTS
%   I- image
%   percent- percentage amplification out of 100
% OUTPUT
%   J- amplified image

% TJ Keemon <keemon@bc.edu>
% October 2007

if percent > 100
    disp('Cannot amplify image greater than 100%');
    J = [];
    return;
end
 
I = imresize(I, 1 + percent*.01);
I2 = rgb2gray(I);
MVert = removalmap(I2,percent/(100+percent)*100,'vertical');
I = shrink(I,MVert,percent/(100+percent)*100,'vertical');
 
I2 = rgb2gray(I);
MHoriz = removalmap(I2,percent/(100+percent)*100, 'horizontal');
I = shrink(I,MHoriz,percent/(100+percent)*100,'horizontal');
J = I;