function [x2, y2] = applyHomography(H, x1,y1)
% applyHomography- converts arrays of points based on given homography
%   
% [x2, y2] = applyHomography(H, x1,y1)
%
% INPUTS
%   H - homography
%   x1 - set of x coordinates
%   y1 - set of y coordinates
% OUTPUTS
%   x2 - new set of x coordinates
%   y2 - new set of y coordinates

% TJ Keemon <keemon@bc.edu>
% December 2007

p(1,:) = x1(:);
p(2,:) = y1(:);
p(3,:) = 1;

x2 = H(1,:) * p;
y2 = H(2,:) * p;
thd  = H(3,:) * p;

x2 = x2 ./ thd;
y2 = y2 ./ thd;
