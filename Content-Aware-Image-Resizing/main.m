function [J] = main(I,process, percentChange, orientation)
% main- runs removalMap for vertical and horizontal seam removal
%
% INPUTS
%   I - rgb image
%   process- the process you want to run
%       'amplification'- amplify image content
%       'expand' - expand image using seams
%       'shrink' - shrink image using seams
%   percentChange - the percent out of 100 to change in the image
%   orientation- which seams to add (not needed for amplification)
%       'vertical' - add vertical seams
%       'horizontal' - add horizontal seams
% OUTPUT
%   J - resulting image

% TJ Keemon <keemon@bc.edu>
% October 2007

if ~strcmp(process, 'amplification') && ~strcmp(orientation, 'vertical') && ~strcmp(orientation, 'horizontal')
    disp('Please enter a valid orientation: "vertical" or "horizontal"');
    J = [];
    return;
end
if percentChange > 100
    disp('Please enter a valid percent change: from 1-100');
    J = [];
    return;
end
 
Igray = rgb2gray(I);
switch process
    case 'amplification'
        J = amplification(I,percentChange);
    case 'shrink'
        M = removalmap(Igray,percentChange, orientation);
        J = shrink(I,M,percentChange,orientation);
    case 'expand'
        M = removalmap(Igray,percentChange, orientation);
        J = myexpand(I,M,percentChange,orientation);
    otherwise
        disp('Please enter a valid process: "amplification", "shrink", or "expand"');
        J = [];
        return;
end