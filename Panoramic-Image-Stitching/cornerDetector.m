function [suppressedCSM] = cornerDetector(image)
% cornerDetector - implements Harris Corner Detector and applies
%           adaptive non-maximal suppression 
% 
% [suppressedCSM] = cornerDetector(image)
%
% INPUT
%   image - RGB image being searched for corners
% OUTPUT
%   suppressedCSM - corner strength map of possible interest points

% TJ Keemon <keemon@bc.edu>
% December 2007

[e1,e2,t] = smm (image,1,1.5);
csm = (e1.*e2)./(e1+e2+eps);

%providing a 25 pixel buffer free of detectable corners
csm([1:25, end-25:end], :) = 0;  
csm(:,[1:25,end-25:end]) = 0;    

max33 = @(x) all( repmat(x(5,:),8,1) > x([1:4,6:9],:) );
csm = csm .* colfilt(csm,[3,3],'sliding',max33);


%
%nonmax suppression of csm
%
[r c v] = find(csm);
distances = zeros (numel(r),1);
suppressedCSM = zeros(size(csm));
    
for i=1:numel(r)
    [reduceR reduceC reduceV] = find(csm*0.9>csm(r(i),c(i)));
    minDist = min(dist2([r(i),c(i)],[reduceR,reduceC]));
    
    if (isempty (minDist))
        minDist = Inf;
    end
    
    distances(i) = minDist;
end        

[sorted prevIndex] = sort(distances,1);    
for j=size(distances,1)-499:size(distances,1)
    suppressedCSM(r(prevIndex(j)),c(prevIndex(j))) = csm(r(prevIndex(j)),c(prevIndex(j)));
end