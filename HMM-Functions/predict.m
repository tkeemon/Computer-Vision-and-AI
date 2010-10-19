
function fk = predict(f1,k,p)
%
% function fk = predict(f1,k,p)
%
% INPUTS
%   f1 = n x 1 vector, forward message at time t = P(X_t|e_{1:t})
%       where n = number of possible values for the state X
%   k = number of steps ahead
%   p = n x n matrix, state transition model = P(X_{t+1}|X_t)
% OUTPUT
%   fk = n x 1 vector, prediction at time t+k = P(X_{t+k}|e_{1:t})

% TJ Keemon <keemon@bc.edu>
% March 5, 2009

fk = f1;
for i = 1:k
    fk = p * fk;
end
