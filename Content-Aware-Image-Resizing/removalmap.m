function [J] = removalmap(I, percent, orientation)
% removalmap - find path to remove pixels in image
%
% INPUTS
%   I - grayscale image
%   percent- percent of the map to create
%   orientation- which seams to remove
%       'vertical' - remove vertical seams
%       'horizontal' - remove horizontal seams
% OUTPUT
%   J - map of removal paths

% TJ Keemon <keemon@bc.edu>
% October 2007

if percent > 100
    disp('Cannot calculate map for more than 100% of pixels');
    J = [];
    return;
end
 
switch orientation
    case 'vertical'
        I = I';
    otherwise
        %leave image alone
end
 
%calculate energy of array
dx = imfilter(I, [-1 0 1]);
dy = imfilter(I, [-1; 0; 1]);
E = ((dx).^2 + (dy).^2).^.5;
%take the image and pad it with values of inf on top and bottom
E = padarray(E,[1 0], inf);
 
%allocate space for the return image
J = inf(size(E));
 
pixels = floor(percent*.01 * size(I,1));
 
for level = 1:pixels
         
    [h w d] = size(E);
    Epath = zeros(h,w); %to hold the path to travel from pixel to pixel
    Esum = zeros(h,w); %to hold the total sum of the energy to that point
    Esum(:,1) = E(:,1); %fill in first column of Esum from image
   
   
    Esum(1,:) = inf;
    Esum(h,:) = inf;
    for x = 2:w
        for y = 2:h-1
            %searches 3 possible pixels back from point location x,y
            path(1) = Esum(y-1,x-1) + E(y,x);
            path(2) = Esum(y,x-1) + E(y,x);
            path(3) = Esum(y+1,x-1) + E(y,x);
 
            min(path);
            %[r, c, v] = find(min(path));
            c = find((path == min(path)),1);
           
            Esum(y,x) = min(path);
            Epath(y,x) = c-2;
        end
    end
   
    row = find((Esum(:,size(E,2)) == min(Esum(:,size(E,2)))),1); %gets starting point in last column
   
    [E removedY] = removepath(E, Epath, row);
    J = map(J, removedY, level);
   
    %figure(1); imshow(E); drawnow();
end
switch orientation
    case 'vertical'
        J = imrotate(J,90);
        J = J(:,2:end-1);
    otherwise
        J = J(2:end-1,:);
end