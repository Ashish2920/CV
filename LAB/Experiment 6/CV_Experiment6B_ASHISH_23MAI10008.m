% Create a video reader
VideoObj = VideoReader('Parade.mp4');

% Count Total frames in video
framecount=VideoObj.NumFrames;
X = ['Total Frames in Video: ',num2str(framecount)];

% Select a Random frame
Rframe = randi([1,framecount]);
Y = ['Random Frame Number: ',num2str(Rframe)];
disp(Y)
image = read(VideoObj,Rframe);

% Display the original image
subplot(1,2,1)
imshow(image);
title('Original Image');

% Load the Haar cascade classifier for face detection
faceDetector = vision.CascadeObjectDetector();

% Detect faces in the image
bbox = step(faceDetector, image);

% Annotate the detected faces on the image
detectedImage = insertObjectAnnotation(image, 'rectangle', bbox, 'Face');

% Display the image with annotated faces
subplot(1,2,2)
imshow(detectedImage);
title('Detected Faces');


sgtitle(["Ashish Kumar 23MAI10008",X,Y])
