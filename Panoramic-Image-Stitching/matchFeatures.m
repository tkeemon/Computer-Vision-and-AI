function [basePts, inputPts] = matchFeatures(des1,des2,csm1,csm2)
% matchFeatures - compares descriptors and corner strength maps 
%       between two images to find complimentary pairs
%
% [des] = getDescriptors(image, csm)
%
% INPUTS
%   image - RGB image containing the features
%   csm - the corner strength map of the image
% OUTPUT
%   des - descriptors from image

% TJ Keemon <keemon@bc.edu>
% December 2007

eDist = dist2 (des1, des2);
    
[r1 c1 v1] = find (csm1);
[r2 c2 v2] = find (csm2);
inputPts = [];
basePts = [];

for i=1:numel(eDist(1,:))
   [minRvalue,minRow] = min(eDist(:,i));
   [minCvalue,minCol] = min(eDist(minRow,:));
   if (minCol == i)
        inputPts = [c1(minRow),r1(minRow);inputPts]; 
        basePts = [c2(i),r2(i);basePts]; 
   end
end