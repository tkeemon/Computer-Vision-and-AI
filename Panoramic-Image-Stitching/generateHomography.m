function [H] = generateHomography(images)
% generateHomography - 
%
% [H] = generateHomography(images, arangement)
%
% INPUT
%   images - cell array of images
% OUTPUT
%   H - homographies for given images

% TJ Keemon <keemon@bc.edu>
% December 2007

num = numel(images);
H = cell(1,numel(images));
H{1} = eye(3);
   
baseCSM = cornerDetector(images{1});
baseDes = getDescriptors(images{1},baseCSM);
for i = 2:num
    csm = cornerDetector(images{i});
    des = getDescriptors(images{i},csm);
    [basePts, inputPts] = matchFeatures(des,baseDes,csm,baseCSM);
    H{i} = ransac(basePts,inputPts);
       
    %clear memory
    clear csm des basePts inputPts
end