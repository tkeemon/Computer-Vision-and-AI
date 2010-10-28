function [v] = ssd(B, I)
% ssd - returns the sum of squared distances between two images
%
% INPUTS
%   B - base image
%   I - image being tested
%OUTPUT
%   v - ssd returned value

% TJ Keemon <keemon@bc.edu>
% October 2007

[h w d] = size(B); %both images will have same dimensions
ignoreV = round(h * 0.1); %ignore 10% of pixels
ignoreH = round(w * 0.1);
v = sum(sum((B(ignoreV:h-ignoreV, ignoreH:w-ignoreH) - I(ignoreV:h-ignoreV, ignoreH:w-ignoreH)).^2));