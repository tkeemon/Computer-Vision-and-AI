function [J] = pyramidalign(I)
% pyramidalign - takes three pictures with three different filters and
%   converts them into rgb image
%
% INPUT
%   I - three images stacked vertically
% OUTPUT
%   J - rgb image returned

% TJ Keemon <keemon@bc.edu>
% October 2007

[h,w,d] = size(I);
B = I(1:floor(h/3) , :);
G = I(floor(h/3) + 1 :(floor(h/3) * 2), :);
R = I((floor(h/3) * 2) + 1 : (floor(h/3)*3), :);

Boffset = alignlevel(G, B, 5);
B = circshift(B, Boffset);
 
Roffset = alignlevel(G, R, 5);
R = circshift(R, Roffset);

%put three images together into rgb image 
J = cat(3, R,G,B);