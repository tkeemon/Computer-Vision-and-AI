function [J] = autoMosaic(images)
% autoMosaic - stitches given images together into a single RGB picture
%
% [J] = autoMosaic(images)
%
% INPUT
%   images - cell array of images
% OUTPUT
%   J - mosaic created from given images

% TJ Keemon <keemon@bc.edu>
% December 2007

num = numel(images);
warpedImages = cell(num);

H = generateHomography(images);

corner = [];
for j = 1:num
   I = images{j};
   [h w d] = size(I);
   crnX = [1;w;1;w];
   crnY = [1;1;h;h];
   
   [x y] = applyHomography(H{j},crnX,crnY);
   corner = [corner; y', x'];
end

[X,Y] = meshgrid(min(corner(:,2)):max(corner(:,2)), ...
    min(corner(:,1)):max(corner(:,1)));

for i = 1:num
    I = images{i};
   [newX,newY] = applyHomography(inv(H{i}),X,Y);
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