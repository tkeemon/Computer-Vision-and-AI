
global CV_CAMERA
global CV_CASCADE

demoTidy();

CV_CAMERA = cvCameraOpen();

pause(1); figure;

I = cell(10,1);
for i = 1:10
    IM = takePicture(1,0,0);
    IM = rgb2gray(IM);
    I{i} = IM;

end
[M S] = determineBackground(I);
 
while 1,
    P = cvCameraFrame(CV_CAMERA);
    PG = rgb2gray(im2single(P));
    
    B = bgSubtract(M,S,PG,2);
    imshow(B);

    drawnow;
end

demoTidy();
