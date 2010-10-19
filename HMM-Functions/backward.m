
function b1 = backward(b2,e2,p,q)
%
% function b1 = backward(b2,e2,p,q)
%
% INPUTS
%   b2 = n x 1 vector, backward message at time k+1 = P(e_{k+2:t}|x_{k+1})
%       where n = number of possible values for the state X
%   e2 = a number betweeen 1 and m, evidence at time k+1 = e_{k+1}
%       where m = number of possible values for the evidence 
%   p = n x n matrix, state transition model = P(X_{t+1}|X_t)
%   q = m x n matrix, sensor model = P(e_t|X_t)
%
% OUTPUT
%   b1 = n x 1 vector, backward message at time k = P(e_{k+1:t}|X_{k})

% TJ Keemon <keemon@bc.edu>
% March 5, 2009

ev = q(e2,:);
b1 = p' * (ev'.*b2);
