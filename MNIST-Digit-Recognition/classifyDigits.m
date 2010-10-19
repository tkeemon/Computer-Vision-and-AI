
function class = classifyDigits(digits,C,S,F,numEig)
% class = classifyDigits(digits,C,S,F,numEig)
% 
% Generates classification for digit images based on their projection in
%   'digitspace'.
%
% INPUTS 
%   digits - n x m x d matrix representing d images of dimension n x m
%   C - matrix representing component coefficient values after pca  
%   S - matrix representing component score after pca
%   F - feature vector for given digits
%   numEig - number of eigenvalues and vectors kept after pca
% OUTPUTS
%   class - the closest digit from the training dataset to the test digit

% TJ Keemon, AI Digit Recognition Project, May 2009

if nargin < 5 | isempty(numEig)
    numEig = 38;
end

[h w ntest] = size(digits);
[ntrain w] = size(S);

disp('running pca on test images');
tic; [dMat C2 S2] = trainPCA(digits,F,'all'); t = toc;
disp(['finished in ' num2str(t)]);
proj = dMat*C;

disp('calculating euclidean distances');
tic;
dist = zeros(ntest,ntrain);
for i = 1:ntest
    I = proj(i,:);
    
    for j = 1:ntrain
        pt = (I'-S(j,1:numEig)');
        dist(i,j) = (pt'*pt)^.5;
    end
    if mod(i,1000)==0
        disp([num2str(i) ' of ' num2str(ntest) ' completed']);
    end
end

[V,class] = min(dist');
t = toc; 
disp(['finished in ' num2str(t)]);