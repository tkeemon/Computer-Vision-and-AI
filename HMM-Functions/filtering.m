
function ft = filtering(p,q,e,f0)
% 
% function ft = filtering(p,q,e,f0)
%
% INPUTS
%   p = n x n matrix, state transition model = P(X_{t+1}|X_t)
%       where n = number of possible values for the state X
%   q = m x n matrix, sensor model = P(e_t|X_t)
%       where m = number of possible values for the evidence 
%   e = 1 x t, sequence of evidence
%       where t is the current time step 
%   f0 = n x 1 vector, initial forward message, default = ones(n,1)/n
% OUTPUT
%   ft = n x 1 vector, forward message at time t = P(X_{t}|e_{1:t})

% TJ Keemon <keemon@bc.edu> 
% March 5, 2009

if nargin < 3
    help filtering
    return
end
if nargin < 4
    n = size(p,1);
    f0 = ones(n,1)/n;
end
t = numel(e);

ft = f0;
for i = 1:t
    ft = forward(ft,e(i),p,q);
end
