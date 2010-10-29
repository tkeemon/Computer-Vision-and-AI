function [H] = ransac(basePts, inputPts)
% ransac - generate homographies based on given sets of points and
%       return the homography that encapsulates the greatest
%       number of inliers
%
% [H] = ransac(basePts, inputPts)
%
% INPUTS
%   basePts - set of points from base image
%   inputPts - set of point from input image
% OUTPUT
%   H - the best homography

% TJ Keemon <keemon@bc.edu>
% December 2007

maxInliers = 0;
xBase = basePts(:,1);
yBase = basePts(:,2);
xInput = inputPts(:,1);
yInput = inputPts(:,2);

for i = 1:10000
   
    randBase = zeros(4,2); 
    randInput = zeros(4,2);
   
    for j = 1:4
       
        index = ceil(rand*(size(basePts,1)-1))+1;
       
        randBase(j,1) = xBase(index); 
        randBase(j,2) = yBase(index);
        randInput(j,1) = xInput(index); 
        randInput(j,2) = yInput(index);
       
    end
   
    h = computeHomography(randInput(:,1),randInput(:,2), ... 
            randBase(:,1),randBase(:,2));
        
    [x,y] = applyHomography(inv(h),xBase,yBase);   
    total = 0;
 
    for j = 1:numel(x)
        sigma = 100;
        error = sum(sum(([xInput(j) yInput(j)] - [x(j) y(j)]).^2));
       
        if  error < sigma         
            total = total + 1;
        end
        
    end
   
    if total > maxInliers
       
        maxInliers = total;
        H = h;
       
    end
end