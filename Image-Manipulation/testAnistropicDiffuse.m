
% Quick script to test the file anistropic_diffuse.m
% Replace the images in the cell array 'I' with any images available
% 'loop' and 'k' vectors can also be changed to test different conditions

% TJ Keemon <keemon@bc.edu>
% September 20, 2009

loop = [1 10 50]; nloop = numel(loop);
k = [.0001 .01  1]; nk = numel(k);

I{1} = im2single(imread('cat.jpg')); I{1} = rgb2gray(I{1});
I{2} = im2single(imread('puppy.jpg')); I{2} = rgb2gray(I{2});
I{3} = im2single(imread('cookie.jpg')); I{3} = rgb2gray(I{3});

nimage = numel(I);

IFK = cell(nimage,nk);
IFL = cell(nimage,nloop);

%%%varying k values
for img = 1:nimage
    for i = 1:nk
        IFK{img,i} = anistropic_diffuse(I{img},k(i),1);
    end
end
%%%showing images
%put originals in subplot
figure;
for img = 1:nimage
    subplot(nimage,nk+1,1+(nk+1)*(img-1)); 
    imshow(I{img});
    title(['Original Image ' num2str(img)]);
end
count = 0;
for i = 1:nimage
    for j = 1:nk
        subplot(nimage,nk+1,1+j+count);
        imshow(IFK{i,j});
        title(['K = ' num2str(k(j)) ' (Loops = 1)']);
    end
    count = count + nk + 1;
end

%%%varying number of loops
for img = 1:nimage
    for i = 1:nloop
        IFL{img,i} = anistropic_diffuse(I{img},.001,loop(i));
    end
end

%%%showing images
%original images
figure;
for img = 1:nimage
    subplot(nimage,nloop+1,1+(nloop+1)*(img-1)); 
    imshow(I{img});
    title(['Original Image ' num2str(img)]);
end
count = 0;
for i = 1:nimage
    for j = 1:nloop
        subplot(nimage,nloop+1,1+j+count);
        imshow(IFK{i,j});
        title(['Loops = ' num2str(loop(j)) ' (K = .001)']);
    end
    count = count + nloop + 1;
end