
function f2 = forward(f1,e2,p,q)
%
% function f2 = forward(f1,e2,p,q)
%
% INPUTS
%   f1 = n x 1 vector, forward message at time t = P(X_t|e_{1:t})
%       where n = number of possible values for the state X
%   e2 = a number betweeen 1 and m, evidence at time t+1 = e_{t+1}
%       where m = number of possible values for the evidence 
%   p = n x n matrix, state transition model = P(X_{t+1}|X_t)
%   q = m x n matrix, sensor model = P(e_t|X_t)
%
% OUTPUT
%   f2 = n x 1 vector, forward message at time t+1 = P(X_{t+1}|e_{1:t+1})

% TJ Keemon <keemon@bc.edu>
% March 5, 2009

ev = q(e2,:);
f2 = (p*f1).*ev';
f2 = f2/sum(f2);
