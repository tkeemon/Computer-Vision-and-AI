% test.m = test smoothing and viterbi

f0 = [0.5;0.5]; p = [0.7,0.3;0.3,0.7]; q = [0.9,0.2; 0.1,0.8];
e = [1,1,2,1,1];

disp('test smoothing ....');
sk = smoothing(p,q,e(1:2),1,f0)
sk = smoothing(p,q,e(1:2),2,f0)
disp('test viterbi ....');
[x,mt,at] = viterbi(p,q,e,f0);
[mt;at;x]


f0 = [0.5;0.5];
p = [0.7,0.3;0.3,0.7]; 
q = [0.9,0.2; 0.1,0.8];
e = [1,2,2,2,1,1,2,2,2];

disp('filtering ....');
kset = [3,4,5];
n = length(kset);
ft = zeros(2,n);
for k=1:n,
    ft(:,k) = filtering(p,q,e(1:kset(k)));
end
ft

disp('prediction ....');
bset = [4,5];
for i=1:2,
    f1 = filtering(p,q,e(1:bset(i)));
    n = 10;
    fk = zeros(2,n);
    for k=1:n,
        fk(:,k) = predict(f1,k,p);
    end
    disp(sprintf('prediction from evidence 1 - %d:',bset(i)));    
    [f1,fk]    
end

disp('smoothing ....');
k = 4;
tset = [4,6,9];
n = numel(tset);
sk = zeros(2,n); disp('stM');
for i=1:n,
    sk(:,i) = smoothing(p,q,e(1:tset(i)),k,f0);
end, disp('endM');
sk

disp('most likely state ....');
ms = zeros(2,9);
for k=1:9,
    ms(:,k) = smoothing(p,q,e,k);
end
[x,x] = max(ms);
x

disp('most likely sequence ....');
[x,mt,at] = viterbi(p,q,e);

% if the evidence lacks continuity
e = [1,2,1,2,1,2,1,2,1];
[x,mt,at] = viterbi(p,q,e);
x