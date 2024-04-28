% load data
my_data = load('dataset.txt');
data_size = size(my_data);
num = data_size(1);
data = my_data(:, 1:2);
fprintf("Data Size:");
disp(data_size);

% normalize data
epsilon = 0.01;
data_mean = mean(data);
data_mean = repmat(data_mean, [num,1]);
data_var = var(data);
data_var = repmat(data_var, [num,1]);
data = (data - data_mean)./sqrt(data_var + epsilon);

% perform k_means algorithm
disp("Performing K-Means Clustering ....")
clusters = 3;
disp("Number of clusters:")
disp(clusters)
[cluster_label, step, final_centers] = k_means(data, clusters, num);

disp('Number of Iterations:');
disp(step);
disp('Final Cluster Centers:');
disp(final_centers);

% Plot the data points with colors representing their clusters
figure;
gscatter(data(:,1), data(:,2), cluster_label);
hold on;
plot(final_centers(:,1), final_centers(:,2), 'kx', 'MarkerSize', 10, 'LineWidth', 2);
title('K-Means Clustering Result');
xlabel('Feature 1');
ylabel('Feature 2');
legend('Cluster 1', 'Cluster 2', 'Cluster 3', 'Cluster Centers');
hold off;


function [label, step, center] = k_means(data, clusters, num)
    % Initialize initial clusters
    index = randperm(num, clusters);
    dis = zeros(num, clusters);
    label = zeros(num, 1);
    center = data(index, :);
    step = 0;
    
    % while loop runs until convergence
    while(1)
        % save the centers for each clusters of last iteration
        pre_center = center;
        % calculate distance between data points and cluster centers
        for i = 1:num
            for j = 1:clusters
                dis(i, j) = norm(data(i,:) - center(j, :));
            end
        end
        % construct new clusters
        for i = 1:num
            label(i) = find(dis(i,:)==min(dis(i,:)));
        end
        % attain new centers
        for i = 1:clusters
            one_cluster = data(label==i, :);
            center(i, :) = mean(one_cluster);
        end
        % test the terminating condition
        if (center == pre_center)
            break;
        end
        step = step + 1;
    end
end
