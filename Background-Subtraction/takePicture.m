
function [P] = takePicture(delay,open,write)
%
%
% INPUTS
%   delay - number of seconds to delay the picture being taken
%   open - flag to indicate whether or not to open and close the camera
%           0 - do not open camera
%           1 - open camera
%   write - flag to indicate whether or not to create .png file
%           0 - do not create file
%           1 - create file
% OUTPUTS
%   P - rgb image from the camera
%

% TJ Keemon <keemon@bc.edu>
% November 17, 2009

if nargin < 1
    delay = 0;
end
if nargin < 2
    open = 0;
end
if nargin < 3
    write = 0;
end

global CV_CAMERA
global CV_CASCADE

if open
    demoTidy();
    CV_CAMERA = cvCameraOpen();
end

pause(delay);

P = cvCameraFrame(CV_CAMERA);
P = im2single(P);

if write, imwrite(P,['./images/' num2str(now) '.png']); end

if open
    demoTidy();
end