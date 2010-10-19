
function [M S] = determineBackground(I)
%
% function [M S] = determineBackground(I)
%
% Computes the average pixel values and standard deviation of all images in
%   'I'
%
% INPUT
%   I - cell array of grayscale background images
% OUTPUTS
%   M - averaged grayscale image 
%   S - standard deviation of all pixel values

% TJ Keemon <keemon@bc.edu>
% November 17, 2009

comp = cat(3,I{:});
M = mean(comp,3);
S = std(comp,0,3);