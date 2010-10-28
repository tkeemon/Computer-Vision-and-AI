function [J] = bruteforce(I)
% bruteforce - takes three pictures with three different filters and
%  converts them into rgb image
%
% INPUT
%   I - three images stacked vertically
% OUTPUT
%   J - rgb image returned

% TJ Keemon <keemon@bc.edu>
% October 2007

[h,w,d] = size(I);
B = I(1:round(h/3) + 1, :);
R = I((round(h/3) * 2) + 1 : end, :);
J = zeros(round(h/3) + 1, w, 3); %to hold final image

J(:,:,2) = I(round(h/3) + 1:(round(h/3) * 2) + 1, :); %green image to be used as anchor
offsetR = getoffset(J(:,:,2), R);
offsetB = getoffset(J(:,:,2), B);

R = circshift(R, offsetR);
B = circshift(B, offsetB);
J(:,:,1) = R(:,:);
J(:,:,3) = B(:,:);