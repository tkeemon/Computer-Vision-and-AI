
function [B] = bgSubtract(BG,BGstd,I,nsd)
%
% function [B] = bgSubtract(BG,BGstd,I)
%
% Creates a mask to remove the background from image 'I'
%
% INPUTS
%   BG - grayscale background image
%   BGstd - standard deviation for each pixel value in BG
%   I - grayscale image to compare against 'BG'
%   nsd - scalar number of standard deviations to allow
% OUTPUTS
%   B - binary image containing mask to remove background from 'I'
%

% TJ Keemon <keemon@bc.edu>
% November 17, 2009

if nargin < 4
    nsd = 3;
end

% +- #std at each pixel
PT = nsd.*BGstd; 
MT = -nsd.*BGstd;

%check which pixel values in 'I' are out of this range
diff = BG - I;

loc = find(diff > PT | diff < MT);

B = zeros(size(I));
B(loc) = 1;

B = bwfill(B,'holes',8);

end