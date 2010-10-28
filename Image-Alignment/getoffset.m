function [a] = getoffset(B, I)
% getoffset- determine how much the image needs to be shifted in order
%  to apprear correctly colored
%
% INPUTS
%   B - base image
%   I - image to move
% OUTPUTS
%   y - vertical displacement
%   x - horizontal displacement

% TJ Keemon <keemon@bc.edu>
% October 2007

min = inf; %set so that first value will be less than sum
for b = -20:20 %vertical displacement
    for c = -20:20 %horizontal displacement
        I2 = circshift(I, [b c]);
        sum = ssd(B, I2); %ssd between green and other color
        if sum < min
            min = sum;
            a = [b c];
        end
    end
end