function [a] = getoffset2(B, I, disp)
% getoffset- determine how much the image needs to be shifted in order
%   to apprear correctly colored
%
% INPUTS
%   B - base image
%   I - image to move
%   disp - area over which to search
% OUTPUT
%   a - vector containing x and y values of displacement

% TJ Keemon <keemon@bc.edu>
% October 2007

min = inf; %set so that first value will be less than sum
for b = -disp:disp %vertical displacement
    for c = -disp:disp %horizontal displacement
        I2 = circshift(I, [b c]);
        sum = ssd(B, I2); %ssd between green and other color
        if sum < min
            min = sum;
            a = [b c];
        end
    end
end