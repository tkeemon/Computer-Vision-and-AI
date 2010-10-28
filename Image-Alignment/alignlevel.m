function [J] = alignlevel(B, I, level)
% alignlevel - aligns current level with level above itself
%
% INPUTS
%   B - base image
%   I - image to align
%   level - level number of pyramid
% OUTPUT
%   J - returned displacement

% TJ Keemon <keemon@bc.edu>
% October 2007

if(level == 0)
    %search over 5 square pixels for iteration on highest level
    J = getoffset2(B,I,5);
else
    B2 = imresize(B, 0.5);
    I2 = imresize(I, 0.5);
   
    %recursive call
    J = (alignlevel(B2, I2, level - 1)).*2;
    I = circshift(I, J);
   
    %searching for offset over 1 pixel
    J = J + getoffset2(B, I, 1);
   
end