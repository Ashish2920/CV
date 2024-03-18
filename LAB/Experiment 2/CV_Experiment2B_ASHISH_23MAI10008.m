A=imread('lena_gr.jpg');
Eq_A =histeq(A);

%H_A = imhist (A, 256);
[row1,column1] = size(A);
H_A= (zeros(1,256));
intensity = 0;
while( intensity <256 )	
    count = 0;
    for i = 1:row1
        for j = 1:column1
            if A(i,j) == intensity
                count = count+1;
            end
        end
    end
    H_A(1,intensity+1) = count;
    intensity = intensity+1;
end

%H_Eq_A= imhist (Eq_A, 256);
[row2,column2] = size(Eq_A);
H_Eq_A= (zeros(1,256));
intensity = 0;
while( intensity <256 )	
    count = 0;
    for i = 1:row2
        for j = 1:column2
            if Eq_A(i,j) == intensity
                count = count+1;
            end
        end
    end
    H_Eq_A(1,intensity+1) = count;
    intensity = intensity+1;
end

figure
subplot(2,2,1); imshow(A)
title("Gray Image")
subplot(2,2,2);bar(H_A);
title("Histogram")

subplot(2,2,3); imshow(Eq_A)
title("Equalized Image")
subplot(2,2,4); bar(H_Eq_A);
title("Equalized Histogram")

sgtitle('Ashish Kumar, 23MAI10008')