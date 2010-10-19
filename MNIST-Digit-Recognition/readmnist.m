
function [L,magicNum] = readmnist(fname)
% [L,magicNum] = readmnist(fname)
%
% Reads the mnist data files and returns either the images or the
% classification based on the file name provided.
%
% INPUT
%   fname = file name from the MNIST digit database
% OUTPUTS
%   L = nimages x 1, labels
%        if fname = 't10k-labels-idx1-ubyte'
%   L = r x c x nimage, images
%        if fname = 't10k-images-idx3-ubyte'
%   magicNum = magic number

% TJ Keemon, AI Digit Recognition Project, May 2009

if nargin < 1 | isempty(fname)
    help(mfilename);
end

char2int = 2.^([3:-1:0]*8);

fid = fopen(fname,'r');
magicNum = char2int * fread(fid,4);
nimage = char2int * fread(fid,4);

if findstr(fname,'images')
    sz = char2int * fread(fid,[4,2]);
    L = reshape(fread(fid,[prod(sz),nimage]),[sz,nimage]);
    L = permute(L,[2,1,3]);
else
    L = fread(fid,nimage);
end
fclose(fid);
