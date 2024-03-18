% Loading Image
im=double(imread('lena_gr.jpg'));
F_u_v=fft2(im);
F_u_v=(fftshift(F_u_v));

subplot(2,3,1); imshow(uint8(im));
title('Original Image');
temp=log(1+abs(F_u_v));
subplot(2,3,4); imshow(temp,[]);
title('Fourier Spectra');

% Idle Lowpass filter
% Creating Transfer function
[M,N]=size(im);

% Set up range of variables.
u = 0:(M - 1);
v = 0:(N - 1);

% Compute the indices for use in meshgrid.
idx = find(u > M/2);
u(idx) = u(idx) - M;
idy = find(v > N/2);
v(idy) = v(idy) - N;

% Compute the meshgrid arrays.
[V, U] = meshgrid(v, u);

% Compute the distances D(U, V).
D0=40;
D = sqrt(U.^2 + V.^2);
H =ifftshift( double(D <=D0));

%Applying the transfer function
g=real(ifft2(H.*F_u_v));

%Crop to original size.
%g=g(1:size(F_u_v,1),1:size(F_u_v,2));
subplot(2,3,5); imshow(uint8(abs(g)));
title('Filtered Image (Low Pass)');

subplot(2,3,2); imshow(H,[]);
title('Idle Lowpass Filter');

% Idle Highpass filter
D0=15;
H =ifftshift( double(D <=D0));
Hp=1-H;
% Applying Highpass filter
g=real(ifft2(Hp.*F_u_v));

subplot(2,3,6); imshow(uint8(abs(g)));
title('Filtered Image (High Pass)');

subplot(2,3,3); imshow(Hp,[]);
title('Idle Highpass Filter');
sgtitle("Ashish Kumar, 23MAI10008")