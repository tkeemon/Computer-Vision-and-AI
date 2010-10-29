function [H] = computeHomography(x1,y1,x2,y2)
% computeHomography - computes homography from given coorisponding points
%           between two images
%
% [H] = computeHomography(x1,y1,x2,y2)
%   
% INPUTS
%   x1 - image 1 x coordinates
%   y1 - image 1 y coordinates
%   x2 - image 2 x coordinates
%   y2 - image 2 y coordinates
% OUTPUT
%   H - homography for transforming one set of image coordinates to the other

% TJ Keemon <keemon@bc.edu>
% December 2007

num = numel(x1);
H = ones(3);

eq = zeros(num*2, 8);
sol = zeros(num*2,1);

%filling in the equations and the solutions matricies to determine
%   homography
for i =1:num
   pts1 = [x1(i),y1(i),1];
   z = [0, 0, 0];
   
   rem = (-1 * [x2(i);y2(i)]) * [x1(i),y1(i)];
   sol((i-1)*2+1:(i-1)*2+2) = [x2(i); y2(i)];
   eq ((i-1)*2+1:(i-1)*2+2,:) = [[pts1, z;z, pts1] rem]; 
end

H = eq\sol;

H(9) = 1;
H = reshape(H,3,3)';