function [J] = map(J, yArray, level)
% map- creates removal time map based on when path is taken from image
%
% INPUTS
%   J- removal time map
%   path- the removed path that needs to be plotted
%   level- iteration through function
% OUTPUT
%   J - updated removal time map

% TJ Keemon <keemon@bc.edu>
% October 2007

for i = numel(yArray):-1:1
    %[x y] = ind2sub(size(J), size(J,2));
    %J = setJpixel(J, i, yArray(i), level);
    whitespace = 0;
    index = 0;
    while yArray(i) ~= whitespace
        index = index + 1;
        if J(index,i) == inf;
            whitespace = whitespace + 1;
        end
    end
    J(index, i) = level;
end