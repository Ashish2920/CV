f = imread('lena_gr.jpg');
h = fspecial('sobel');

PQ = paddedsize(size(f));
F = fft2(double(f), PQ(1), PQ(2));
H = fft2(double(h), PQ(1), PQ(2));
F_fH = H.*F;
ff1 = ifft2(F_fH);
ff2 = ff1(2:size(f,1)+1, 2:size(f,2)+1);

%Display results (show all values)
subplot(3,3,1), imshow(f);
subplot(3,3,2), imshow(log(abs(fftshift(F))),[]);
subplot(3,3,3), imshow(log(abs(fftshift(H))),[]);
subplot(3,3,4), imshow(log(abs(fftshift(F_fH))),[]);
subplot(3,3,5), imshow(ff1,[]);
subplot(3,3,6), imshow(ff2,[]);
%The abs function gets correct magnitude
%when used on complex numbers
ffim = abs(ff2);
subplot(3,3,7), imshow(ffim,[]);
sgtitle("Ashish Kumar, 23MAI10008");

function PQ = paddedsize(AB, CD, PARAM)
    if nargin == 1
        PQ = 2*AB;
    elseif nargin == 2 && ~ischar(CD)
     PQ = AB + CD - 1;
     PQ = 2 * ceil(PQ / 2);
    elseif nargin == 2
     m = max(AB); % Maximum dimension.
     % Find power-of-2 at least twice m.
     P = 2^nextpow2(2*m);
     PQ = [P, P];
    elseif nargin == 3
     m = max([AB CD]); %Maximum dimension.
     P = 2^nextpow2(2*m);
     PQ = [P, P];
    else
     error('Wrong number of inputs.')
    end
end