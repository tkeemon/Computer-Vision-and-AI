function [des] = getDescriptors(image, csm)
% getDescriptors - extracts descriptors from the provided image based
%       on its corner strength map
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

image = rgb2gray(image);
blurred2 = imfilter(image,fspecial('gaussian',[15,15],2.5),'symmetric');

[y x v] = find(csm);
num = numel(x);


[X, Y] = meshgrid(-18:5:17,-18:5:17);
X = X(:);
Y = Y(:);
    
desX = zeros(num,64);
desY = zeros(num,64);
 
for i = 1:num
    desX(i,:) = X + x(i);
    desY(i,:) = Y + y(i);  
end
  
des = interp2(blurred2,desX,desY);

%normalizing
des = des - (mean(des,2) * ones(1,64));
des = des ./ (sqrt(var(des'))'*ones(1,64));