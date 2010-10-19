
function [x,mt,at] = viterbi(p,q,e,f0)
%
% function [x,mt,at] = viterbi(p,q,e,f0)
%
% INPUTS
%   p = n x n matrix, state transition model = P(X_{t+1}|X_t)
%       where n = number of possible values for the state X
%   q = m x n matrix, sensor model = P(e_t|X_t)
%       where m = number of possible values for the evidence 
%   e = 1 x t, sequence of evidence
%       where t is the current time step 
%   f0 = n x 1 vector, initial message, default = ones(n,1)/n
%
% OUTPUTS
%   x = 1 x t vector, most likely sequence from time 1 to t  
%   mt = n x t vector, message from time 1 to t
%       each column is \max_{x_{1:t-1}} P(x_{1:t-1},X_t|e_{1:t})
%   at = n x t vector, best transition leading to each state
%       each column is \arg \max_{x_t} ( P(X_{t+1}|x_t) m_{1:t} )

% TJ Keemon <keemon@bc.edu>
% March 5, 2009

if nargin < 1
    help viterbi
    return
end

n = size(p,1);
t = numel(e);

if nargin < 4 
    f0 = ones(n,1)/n;
end

mt = zeros(n,t);
at = zeros(n,t);

m = filtering(p,q,e(1),f0);
mt(:,1) = m;
[k k] = max(m);
at(:,1) = repmat(k,n,1);

for i = 2:t,
    z = p.* repmat(m',n,1);
    [m at(:,i)] = max(z,[],2);
    m = m .* q(e(i),:)';
    
    % normalize result
    m = m / sum(m);
    mt(:,i) = m;
end

x = zeros(1,t);
[z x(t)] = max(m);
for i = t-1:-1:1,
    x(i) = at(x(i+1),i+1);
end
