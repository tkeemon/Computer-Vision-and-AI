function [newIpath] = findpath(Ipath, rowNum)
% findpath- expands the given column
%
% INPUTS
%   Ipath- image path being expanded
%   rowNum- location of pixel to duplicate
% OUTPUT
%   newIpath- path to be returned

% TJ Keemon <keemon@bc.edu>
% October 2007

newIpath = zeros(size(Ipath,1) + numel(rowNum),1);
 
rowIndex = 1;
newPathIndex = 1;
for i = 1:size(Ipath,1)
    newIpath(newPathIndex,1) = Ipath(i);
    newPathIndex = newPathIndex + 1;
   
    if rowNum(rowIndex) == i
        newIpath(newPathIndex,1) = Ipath(i); %repeats given pixel
        newPathIndex = newPathIndex + 1;
        rowIndex = rowIndex + 1;
    end
end