% Input data and targets
x1 = [-1 -1 1 1];
x2 = [-1 1 -1 1];
% Combine them into one array
x = [x1' x2'];
t = [-1 -1 -1 1];

% Initialize values
w1 = input('Enter weight w1: ');
w2 = input('Enter weight w2: ');
w = [w1 w2];
a = input('Enter the value for the Learning Rate, Alpha: ');
theta = input('Enter the value for the Threshold, Theta: ');
b = input('Enter the value for the b: ');

fprintf('\n\n');
disp('Perceptron Algorithm for AND function: ');
fprintf('x1 = [%d, %d, %d, %d]\n', x1);
fprintf('x2 = [%d, %d, %d, %d]\n', x2);
fprintf('t = [%d, %d, %d, %d]\n', t);

% Start Training for model
fprintf('\nTraining Started .....\n');

% Set maximum number of epochs
max_epochs = 1000;
% Number of input samples
[row_of_possible_inputs, ~] = size(x);

for epoch = 1:max_epochs
    fprintf('\nEpoch = %d\n', epoch);
    errors = 0;
    
    for i = 1:row_of_possible_inputs
        % Calculate s
        s = b + dot(w, x(i,:));
        
        if s > theta
            y = 1;
        else
            y = -1;
        end
        
        if y ~= t(i)
            % Update weights
            w = w + a * t(i) * x(i,:);
            % Update bias
            b = b + a * t(i);
            errors = errors + 1;
        end
        
        fprintf('s = %.2f \ty = %d\tb = %.2f\n', s, y, b);
    end
    
    % Stop if all samples are classified correctly
    if errors == 0
        fprintf('\nTraining Converged\n');
        break;
    end
end

if epoch == max_epochs
    fprintf('\nMaximum epochs reached. Training may not have converged.\n');
end
