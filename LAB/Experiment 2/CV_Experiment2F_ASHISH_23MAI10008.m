f = imread('lena_gr.jpg');
subplot(1,2,1); imshow(f);
title("Original Image")

f = double(f);
F = fftshift(fft2(f));
[m,n] = size(f);
sig = 10;
H = Gaussian(m, n, sig);
G = H.*F;
g = abs(ifft2(G));
subplot(1,2,2); imshow(g,[]);
title("Gaussian Filter (sigma = 10)")
sgtitle("Ashish Kumar, 23MAI10008");

function H = Gaussian(m, n, sigma)
    [X, Y] = meshgrid(-(n-1)/2:(n-1)/2, -(m-1)/2:(m-1)/2);
    H = exp(-(X.^2 + Y.^2) / (2 * sigma^2));
    H = H / (2 * pi * sigma^2);  % Normalize the filter
end