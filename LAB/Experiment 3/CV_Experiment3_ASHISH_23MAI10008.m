% Read an image from file
originalImage = imread('peppers.jpg');

% Display the original image
subplot(1,2,1)
imshow(originalImage);
title('Original Image');

% Convert the image to Lab color space
labImage = rgb2lab(originalImage);


% Reshape the image for mean shift
reshapedImage = reshape(labImage, [], 3);

% Perform mean shift clustering
[clusterIndices, ~] = meanShiftSegmentation(reshapedImage);

% Reshape the cluster indices to the original image size
segmentedImageMeanShift = reshape(clusterIndices, size(originalImage, 1), size(originalImage, 2));

% Display the segmented image using mean shift
subplot(1,2,2)
imshow(label2rgb(segmentedImageMeanShift));
title('Segmented Image (Mean Shift)');
sgtitle("Ashish Kumar 23MAI10008")


% Implementation of the meanShiftSegmentation function
function [clusterIndices, clusterCenters] = meanShiftSegmentation(data, bandwidth)
    if nargin < 2
        bandwidth = 15; % Default bandwidth
    end
    
    [numPoints, ~] = size(data);
    clusterIndices = zeros(numPoints, 1);
    clusterCenters = zeros(numPoints, size(data, 2)); % Initialize cluster centers
    
    % Iterate through each point
    for i = 1:numPoints
        x = data(i, :);
        fprintf("Done %d\n",i);
        % Mean shift
        while true
            % Compute distances to all points
            distances = sqrt(sum((repmat(x, numPoints, 1) - data).^2, 2));
            
            % Find points within the bandwidth
            withinBandwidth = distances < bandwidth;
            nearbyPoints = data(withinBandwidth, :);
            
            % Calculate mean shift vector
            shift = mean(nearbyPoints, 1) - x;
            
            % Update position
            x = x + shift;
            
            % Check for convergence
            if norm(shift) < 1e-5
                break;
            end
            
        end
        
        % Assign cluster index
        [~, clusterIndices(i)] = ismember(round(x), round(clusterCenters), 'rows');
        
        % Update cluster center if new
        if clusterIndices(i) == 0
            clusterCenters(i, :) = x;
        end
    end
    
    % Generate unique cluster indices
    [~, ~, clusterIndices] = unique(clusterIndices);
end
