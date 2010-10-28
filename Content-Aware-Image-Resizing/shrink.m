function [J] = shrink(I,map,pixels,orientation)
% shrink- shrinks image by number of pixels given
%
% INPUTS
%   I- image
%   map- seam removal map
%   pixels- percentage of pixels to remove
%   orientation- which seams to remove
%       'vertical' - remove vertical seams
%       'horizontal' - remove horizontal seams
% OUTPUT
%   J- return image

% TJ Keemon <keemon@bc.edu>
% October 2007

if pixels > 100
    disp('Cannot remove more than 100% of pixels');
    J = [];
    return;
end
 
switch orientation
    case 'vertical'
        I = imrotate(I,-90);
        map = imrotate(map,-90);
    otherwise
        %leave image alone
end
 
R = I(:,:,1);
G = I(:,:,2);
B = I(:,:,3);
 
I = rgb2gray(I);
[h w d] = size(I);
 
numPaths = floor((pixels *.01) * size(map,1));
newH = h - numPaths;
 
path = zeros(numPaths * size(map,2),1); %to hold all path values
 
path = find(map <= numPaths);
 
R(path) = [];
G(path) = [];
B(path) = [];
 
Rnew = zeros(newH, w);
Gnew = zeros(newH, w);
Bnew = zeros(newH, w);
 
Rnew(:) = R;
Gnew(:) = G;
Bnew(:) = B;
 
J = cat(3,Rnew,Gnew,Bnew);

switch orientation
    case 'vertical'
        J = imrotate(J,90);
    otherwise
        %do nothing
end