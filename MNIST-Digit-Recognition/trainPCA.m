
function [dMat C S] = trainPCA(digits,F,numEig)
% [dMat C S] = trainPCA(digits,numEig)
%
% Creates an 'eigendigit' based on the number inputted images, then computes
%   the projection of digits onto 'digitspace'.
%
% INPUTS
%   digits - n x m x d matrix representing d images of dimension n x m
%   F - feature vector
%   numEig - number of eigenvectors and eigenvalues to keep after pca
%       # - use eigenvectors 1 to #
%       'all' - use all eigenvectors
% OUTPUTS
%   dMat - normalized digit matrix from the set of inputted digits
%   C - matrix representing component coefficient values after pca  
%   S - matrix representing component score after pca  
%   

% TJ Keemon, AI Digit Recognition, May 2009

if nargin < 3 | isempty(numEig)
    numEig = 38;
end

[h w nd] = size(digits); 

%create np x nd matrix from digits made into column vectors
dMat = zeros(h*w,nd);
for i = 1:nd
    dig = digits(:,:,i);
    dMat(:,i) = dig(:);
end
% add the feature vector 
dMat = [dMat; F];
%normalize by mean
meanDigit = mean(dMat,2);
dMat = (dMat - repmat(meanDigit,[1 nd]))';

% use pca, then reduce to the first numEig values if necessary
[C S L]=princomp(dMat,'econ');
if ~strcmp(numEig,'all')
    C = C(:,1:numEig);
end
