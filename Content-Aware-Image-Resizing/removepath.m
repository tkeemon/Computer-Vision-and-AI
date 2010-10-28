function [Enew, removeY] = removepath(E, Epath, row)
% removepath - starts from the last column in E and backtracks to remove
%   a connected path of pixels
%
% INPUTS
%   E- the energy function of the image
%   Epath - matrix denoting path from one pixel to the next
%   row- the starting row in the last column
% OUTPUTS
%   Enew- E after range of pixels has been removed
%   pathArray- the path removed from E

% TJ Keemon <keemon@bc.edu>
% October 2007

col = size(Epath, 2);
path = zeros(1,size(Epath, 2));
removeY = zeros(size(path));
 
for i=1:size(Epath, 2)
    row = row + Epath(row,col);
    path(i) = sub2ind(size(Epath), row, col);
    removeY(i) = row;
   
    col = col -1;
end
 
 
[oldH oldW] = size (E);
%clear out values from array of path taken
E(path) = [];
Enew = zeros (oldH -1, oldW);
 
Enew(:) = E;