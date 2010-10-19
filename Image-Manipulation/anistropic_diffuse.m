
function [g] = anistropic_diffuse(f,K,n)
%
% function [g] = anistropic_diffuse(f,K,n)
%
% anistropic diffusion - Image bluring based on image structure. Preserves
%   strong edges while bluring flat areas.
%
% Diffusion factor function
%   w(x) = K/(K+x^2)
%       where:
%           K = diffusion factor
%           x = difference of neighboring pixels
% 
% INPUTS
%   f - grayscale image
%   K - diffusion factor
%   n - number of iterations
% OUTPUT
%   g - grayscale image after anistropic diffusion
%

% TJ Keemon <keemon@bc.eud>
% September 20, 2009

dp = [1 0; 0 1; -1 0; 0 -1];
g = zeros(size(f));
W = zeros(size(f));

for iter = 1:n
    %create weight matrix and pad image
    W = zeros(size(f));
    fp = padarray(f,[1 1],'symmetric','both');
    for i = 1:4
        mv = dp(i,:);
        md = fp(2+mv(1):(end-1)+mv(1),2+mv(2):(end-1)+mv(2))-f;
        W = W + ((K.*md)./(K + md.^2)); 
    end
    g = f + W./4;
    f = g;
end
