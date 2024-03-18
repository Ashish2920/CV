% Read an image from file
image = imread('lena.png');

% Display the original image
subplot(2,2,1)
imshow(image);
title('Original Image');

% Load the Haar cascade classifier for face detection
faceDetector = vision.CascadeObjectDetector();

% Detect faces in the image
bbox = step(faceDetector, image);

% Annotate the detected faces on the image
detectedImage = insertObjectAnnotation(image, 'rectangle', bbox, 'Face');

% Display the image with annotated faces
subplot(2,2,2)
imshow(detectedImage);
title('Detected Faces');


% Customize face detection parameters
% Adjust the scale factor for face detection
faceDetector.ScaleFactor = 3.3;
% Detect faces with the updated parameters
bboxUpdated = step(faceDetector, image);

% Annotate the detected faces on the image
detectedImageUpdated = insertObjectAnnotation(image, 'rectangle', bboxUpdated, 'Face');
% Display the image with annotated faces after customization
subplot(2,2,3)
imshow(detectedImageUpdated);
title('Scale Factor =3.3');

% Adjust the scale factor for face detection
faceDetector.ScaleFactor = 1.5;
% Detect faces with the updated parameters
bboxUpdated = step(faceDetector, image);

% Annotate the detected faces on the image
detectedImageUpdated = insertObjectAnnotation(image, 'rectangle', bboxUpdated, 'Face');
% Display the image with annotated faces after customization
subplot(2,2,4)
imshow(detectedImageUpdated);
title('Scale Factor =1.5');

sgtitle("Ashish Kumar 23MAI10008")
