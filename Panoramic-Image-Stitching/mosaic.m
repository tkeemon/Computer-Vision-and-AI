function [J] = mosaic(images,basePts,inputPts)
% mosaic - stich multiple images together given a set of coorisponding
%      points between the images
%
% [J] = mosaic(images,basePts,inputPts)
%
% INPUTS
%   images - cell array of images to be mosaiced
%   basePts - cell array of coordinates for given image
%   inputPts - cell array of coordinates for matching points in next image
% OUTPUT
%   J - the single mosaiced picture

% TJ Keemon <keemon@bc.edu>
% December 2007

num = numel(images);
H = cell(1,num);
H{1} = eye(3);
warpedImages = cell(num);

for i = 2:num
    H{i} = computeHomography(inputPts{i-1}(:,1),inputPts{i-1}(:,2), ...
        basePts{i-1}(:,1), basePts{i-1}(:,2));
end

corner = [];
for j = 1:num
   I = images{j};
   [h w d] = size(I);
   crnX = [1;w;1;w];
   crnY = [1;1;h;h];
   
   [x y] = applyHomography(inv(H{j}),crnX,crnY);
   corner = [corner; y', x'];
end

[X,Y] = meshgrid(min(corner(:,2)):max(corner(:,2)), ...
    min(corner(:,1)):max(corner(:,1)));

for i = 1:num
    I = images{i};
   [newX,newY] = applyHomography(H{i},X,Y);
   warpedImages{i}(:,:,1) = interp2(I(:,:,1),newX,newY,'*cubic');
   warpedImages{i}(:,:,2) = interp2(I(:,:,2),newX,newY,'*cubic');
   warpedImages{i}(:,:,3) = interp2(I(:,:,3),newX,newY,'*cubic');
   
   warpedImages{i} = reshape(warpedImages{i}(:,:,:),[size(X),3]);
end

J = zeros(size(warpedImages{1}));
for j = 1:num
    useable = ~isnan(warpedImages{j});
    J(useable) = warpedImages{j}(useable);
    
end
