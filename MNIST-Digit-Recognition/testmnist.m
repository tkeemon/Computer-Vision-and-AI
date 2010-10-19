
function accuracy = testmnist
% function testmnist.m = test mnist digit dataset
% required files:
%   t10k-labels-idx1-ubyte
%   t10k-images-idx3-ubyte
% files can be obtained from: http://yann.lecun.com/exdb/mnist/

% TJ Keemon, AI digit recognition project, May 2009.

Ls = readmnist('t10k-labels-idx1-ubyte');
Is = readmnist('t10k-images-idx3-ubyte');


%Is = normalizeDigits(Is);
% training on the first 1000 digits in the dataset
ntrain = 1000;
% %disp('generating feature vectors for the training data');
% %tic; V = getFeatureVector(Is(:,:,1:ntrain)); t = toc;
% %disp(['finished in ' num2str(t)]);
V = [];
disp('running pca on training images');
tic; [dMat C S] = trainPCA(Is(:,:,1:ntrain),V); t = toc;
disp(['finished in ' num2str(t)]);


%disp(['generating feature vector for the test data']);
%tic; V = getFeatureVector(Is(:,:,ntrain+1:end)); t = toc;
%disp(['finished in ' num2str(t)]);
class = classifyDigits(Is(:,:,ntrain+1:end),C,S,V);

% check accuracy and generate confusion matrix
accuracy = zeros(10,1);
totals = zeros(10,1);
confMatrix = zeros(10);
ntest = length(class);
for i = 1:ntest
    pred = Ls(class(i));
    label = Ls(ntrain+i);
    
    accuracy(label+1) = accuracy(label+1) + (pred==label);
    totals(label+1) = totals(label+1) + 1;
    
    confMatrix(pred+1,label+1) = confMatrix(pred+1,label+1) + 1;
end
accuracy = accuracy ./ totals;

disp(accuracy);
disp(confMatrix);