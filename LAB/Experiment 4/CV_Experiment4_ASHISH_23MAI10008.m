% Read the image
I = imread('cameraman.tif');

% Detect SIFT features in the image
points = detectSIFTFeatures(I);

% Display the image
subplot(2,1,1), imshow(I);
title("Detected Points:")

hold on;
% Overlay the strongest 10 SIFT features on the image and show their orientations
plot(points.selectStrongest(10),'showOrientation',true);
hold off;

% Read two images
I1 = imread("cameraman.tif");
I2 = imresize(imrotate(I1,-20),1.2);

% Detect SIFT features
points1 = detectSIFTFeatures(I1);
points2 = detectSIFTFeatures(I2);

% Extract feature descriptors
[features1, valid_points1] = extractFeatures(I1, points1.selectStrongest(30));
[features2, valid_points2] = extractFeatures(I2, points2.selectStrongest(30));

% Match features
indexPairs = matchFeatures(features1, features2);

% Retrieve matched points
matchedPoints1 = valid_points1(indexPairs(:,1), :);
matchedPoints2 = valid_points2(indexPairs(:,2), :);

subplot(2,1,2)
showMatchedFeatures(I1,I2,matchedPoints1,matchedPoints2,'montage');
title('Matching Points:');
sgtitle("Ashish Kumar 23MAI10008")