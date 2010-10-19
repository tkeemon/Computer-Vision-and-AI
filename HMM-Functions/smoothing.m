
function sk = smoothing(p,q,e,k,f0)
%
% function sk = smoothing(p,q,e,k,f0)
%
% INPUTS
%   p = n x n matrix, state transition model = P(X_{t+1}|X_t)
%       where n = number of possible values for the state X
%   q = m x n matrix, sensor model = P(e_t|X_t)
%       where m = number of possible values for the evidence 
%   e = 1 x t, sequence of evidence
%       where t is the current time step 
%   k = 1 x 1, a time step between 1 and t
%   f0 = n x 1 vector, initial forward message, default = ones(n,1)/n
% OUTPUT
%   sk = n x 1 vector, smoothed message at time k = P(X_k|e_{1:t})

% TJ Keemon <keemon@bc.edu>
% March 5, 2009

if nargin < 4
    help smoothing
    return
end

n = size(p,1);

if nargin < 5
    f0 = ones(n,1)/n;
end
t = numel(e);

ft = filtering(p,q,e(1:k),f0);

bk = ones(n,1);
for i = t:-1:k+1
    bk = backward(bk,e(i),p,q)
end
sk = ft .* bk;
sk = sk/sum(sk);
end