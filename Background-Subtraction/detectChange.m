global CV_CAMERA
global CV_CASCADE

demoTidy();

CV_CAMERA = cvCameraOpen();

pause(1); 

I = cell(10,1);
for i = 1:10
    IM = takePicture(1,0,0);
    IM = rgb2gray(IM);
    I{i} = IM;

end
[M S] = determineBackground(I);

%cycle through camera frames
figure;
while 1,
    P = cvCameraFrame(CV_CAMERA);
    P = im2single(P);
    PG = rgb2gray(P);
    
    B = bgSubtract(M,S,PG,2);
    L = bwlabel(B);
    
    %find the largest object and track it
    s  = regionprops(L,'Area','BoundingBox');
    area = cat(1,s.Area);
    [varea x] = max(area);
    BB = cat(1, s.BoundingBox);
    BB = BB(x,:);
    imshow(P);
    
    %if there is some large object that is not noise
    if varea > 1500
        hold on;
        plot([BB(1) BB(1)+BB(3)],[BB(2) BB(2)],'r-','LineWidth',1);
        plot([BB(1)+BB(3) BB(1)+BB(3)],[BB(2) BB(2)+BB(4)],'r-','LineWidth',1);
        plot([BB(1) BB(1)+BB(3)],[BB(2)+BB(4) BB(2)+BB(4)],'r-','LineWidth',1);
        plot([BB(1) BB(1)],[BB(2) BB(2)+BB(4)],'r-','LineWidth',1);
        hold off;
    end
    drawnow;
end

demoTidy();