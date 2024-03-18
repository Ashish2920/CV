f = imread('lena_gray.png');
subplot(2,3,1), imshow(f);
title("PNG Image");

% Convert format of image
imwrite(f,'lena_gr.jpg');

g = imread('lena_gr.jpg');
subplot(2,3,2), imshow(g);
title("JPG Image");

% Complement of image  (255-value)
%h1 = imcomplement(g);
h1 = 255-g;
subplot(2,3,3), imshow(h1);
title("Complement");

% Convert pixels into 0 to 1 for specific operation
%h2 = imadjust(g, [0 1], [1 0]);
min_input = 0 * 255;
max_input = 1 * 255;
min_output = 1 * 255;
max_output = 0 * 255;
h2 = (double(g) - min_input) * ((max_output - min_output) / (max_input - min_input)) + min_output;
h2 = uint8(h2);
subplot(2,3,4), imshow(h2);
title("Adjusted Image 1");

% Mapping of pixels
%h3 = imadjust(g, [0.3 0.7], [0.2 1.0]);
min_input = 0.3 * 255;
max_input = 0.7 * 255;
min_output = 0.2 * 255;
max_output = 1.0 * 255;
h3 = (double(g) - min_input) * ((max_output - min_output) / (max_input - min_input)) + min_output;
h3 = uint8(h3);
subplot(2,3,5), imshow(h3);
title("Adjusted Image 2");

% Convert pixel back into 0 to 255
m = 0.5;  E = 0.5;
ff = 1./(1+(m./(double(g)+eps)).^E);
gg = im2uint8(mat2gray(ff));
subplot(2,3,6),imshow(gg);
title("Transformed Image");

sgtitle('Ashish Kumar, 23MAI10008')