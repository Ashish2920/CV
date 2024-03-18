% Read color image
color_image = imread('lena_color.png');
subplot(3,3,1), imshow(color_image)
title("Original Image")

% Breakdown RGB image into R, G and B components
R=color_image(:, :, 1);
subplot(3,3,2), imshow(R)
title("R");

G=color_image(:, :, 2);
subplot(3,3,3), imshow(G)
title("G");

B=color_image(:, :, 3);
subplot(3,3,4), imshow(B);
title("B");


% Convert each pixel of RGB image into grayscale image
gray_image=(R*0.2989)+(G*0.5870)+(B*0.114);
subplot(3,3,5), imshow(gray_image);
title("Standard GrayScale")

% Convert each pixel of RGB image into grayscale image
gray_image1=(R*0.1989)+(G*0.4870)+(B*0.214);
subplot(3,3,6), imshow(gray_image1);
title("Customised GrayScale1")

% Convert each pixel of RGB image into grayscale image
gray_image2=(R*0.3989)+(G*0.4870)+(B*0.314);
subplot(3,3,7), imshow(gray_image2);
title("Customised GrayScale2")

% Convert each pixel of RGB image into grayscale image
gray_image3=(R*0.3989)+(G*0.7870)+(B*0.514);
subplot(3,3,8), imshow(gray_image3);
title("Customised GrayScale3")

% Combine the three components back into image
rgbImage = cat(3, gray_image1, gray_image2, gray_image3);
subplot(3,3,9), imshow(rgbImage)
title("Combined Image")

sgtitle('Ashish Kumar, 23MAI10008')