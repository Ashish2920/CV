% Load the images
image1 = imread('Image1.png');
image2 = imread('Image2.png');

% Display the images
sgtitle("Ashish Kumar 23MAI10008")
subplot(2, 2, 1);
imshow(image1);
title('Image 1');
subplot(2, 2, 2);
imshow(image2);
title('Image 2');

% Convert images to grayscale
grayImage1 = rgb2gray(image1);
grayImage2 = rgb2gray(image2);

% Detect and extract features from the images
points1 = detectSURFFeatures(grayImage1);
points2 = detectSURFFeatures(grayImage2);
[features1, validPoints1] = extractFeatures(grayImage1, points1);
[features2, validPoints2] = extractFeatures(grayImage2, points2);

% Match features between the images
indexPairs = matchFeatures(features1, features2);

% Retrieve the locations of the matched points
matchedPoints1 = validPoints1(indexPairs(:, 1), :);
matchedPoints2 = validPoints2(indexPairs(:, 2), :);

% Visualize the matched points
subplot(2, 2, 3);
showMatchedFeatures(image1, image2, matchedPoints1, matchedPoints2, 'montage');
title('Matching Points');

% Check if there are enough matches to continue
if size(indexPairs, 1) < 4
    title('No Matching Points');
    disp('Not enough matches found for stitching!!');
else
    % Use RANSAC to estimate the transformation matrix
    [tform, inlierPoints1, inlierPoints2] = estimateGeometricTransform(matchedPoints1, matchedPoints2, 'affine');

    % Use the transformation matrix to stitch the images
    outputView = imref2d(size(grayImage1));
    panorama = imwarp(image1, tform, 'OutputView', outputView);
    % Blend the images together
    panorama = imfuse(panorama, image2, 'blend', 'Scaling','joint');

    % Display the stitched image
    subplot(2, 2, 4);
    imshow(panorama);
    title('Stitched Image');
end