% Read the video file
videoFile = 'optical.mp4'; 
videoObject = VideoReader(videoFile);

% Read the initial frame 
prevFrame = readFrame(videoObject);
prevFrameGray = rgb2gray(prevFrame);

% Create optical flow objectclc
opticFlow = opticalFlowLK('NoiseThreshold',0.01);

while hasFrame(videoObject)
    % Read the current frame
    currFrame = readFrame(videoObject);
    currFrameGray = rgb2gray(currFrame);
    
    % Estimate optical flow
    flow = estimateFlow(opticFlow, prevFrameGray);
    
    % Display optical flow
    imshow(currFrame);
    hold on;
    plot(flow, 'DecimationFactor', [5 5], 'ScaleFactor', 10);
    hold off;
    drawnow;
    
    % Update previous frame
    prevFrameGray = currFrameGray;
end