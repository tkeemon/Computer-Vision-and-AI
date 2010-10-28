function [J] = myexpand(I,map,pixels,orientation)
% myexpand- expands image by number of pixels given
%
% INPUTS
%   I- image
%   map- seam removal map
%   pixels- percentage of pixels to add
%   orientation- which seams to add
%       'vertical' - add vertical seams
%       'horizontal' - add horizontal seams
% OUTPUT
%   J- return image

% TJ Keemon <keemon@bc.edu>
% October 2007

if pixels > 100
    disp('Cannot add more than 100% of pixels');
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
newH = h + numPaths + 1;
Rnew = zeros(newH, w);
Gnew = zeros(newH, w);
Bnew = zeros(newH, w);
 
path = zeros(numPaths + 1,1); %to hold all path values 
for i = 1:w
    path = find(map(:,i) <= numPaths);
    path(numPaths + 1,1) = inf; %prevents overflow error
    Rnew(:,i) = findpath(R(:,i), path);
    Gnew(:,i) = findpath(G(:,i), path);
    Bnew(:,i) = findpath(B(:,i), path);
 
end

J = cat(3,Rnew,Gnew,Bnew);

switch orientation
    case 'vertical'
        J = imrotate(J,90);
    otherwise
        %do nothing
end