%load in lunar north pole image
f=imread('moonB.png');     

% creates 3x3 laplacian, alpha=0 [0:1]
w4=fspecial('laplacian',0); 
% create a Laplacian that fspecial can’t
w8=[1 1 1;1 -8 1;1 1 1];            

% output same as input unit8 so negative values are truncated.
% Convert to double to keep negative values.
f=im2double(f);                      

% filter using default values
g4=f-imfilter(f,w4,'replicate');
% filter using default values
g8=f-imfilter(f,w8,'replicate');  

% Sobel Filter
h = fspecial('sobel');
sfi = imfilter(double(f),h, 0, 'conv');

figure
% display original image
subplot(2,4,1); imshow(f);                             
title('Original Image');
subplot(2,4,2),imshow(sfi, []);
title("Sobel Filter")
% display g4 processed image
subplot(2,4,3); imshow(g4);                           
title('Laplace Filter 1');
% display g8 processed image
subplot(2,4,4); imshow(g8);                           
title('Laplace Filter 2');


I = imread('moonB.png');
subplot(2,4,5);imshow(I);title('Original Image'); 

H = fspecial('motion',50,45);
MotionBlur = imfilter(I,H);
subplot(2,4,6);imshow(MotionBlur);title('Motion Blurred Image');

H = fspecial('disk',10);
blurred = imfilter(I,H);
subplot(2,4,7);imshow(blurred);title('Blurred Image');

H = fspecial('unsharp');
sharpened = imfilter(I,H);
subplot(2,4,8);imshow(sharpened);title('Sharpened Image');

sgtitle('Ashish Kumar, 23MAI10008')