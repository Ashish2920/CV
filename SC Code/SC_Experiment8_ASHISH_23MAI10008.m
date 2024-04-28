fprintf("Particle Swarm Optimization (PSO) Algorithm: \n")
% Define the Objective function (Rastrigin function)
fun = @(x) sum(x.^2 - 10 * cos(2 * pi * x) + 10, 2);

% Initialization
nDims = 2; % Number of dimensions
lb = -5.12 * ones(1, nDims); % Lower bound for each dimension
ub = 5.12 * ones(1, nDims); % Upper bound for each dimension
nParticles = 20; % Number of particles in the swarm
maxIter = 50; % Maximum number of iterations
fprintf("Number of dimension: %d\n",nDims);
fprintf("Number of particles in Swarm: %d\n",nParticles);
fprintf("Maximum number of Iterations: %d\n\n",maxIter);

% Initialize the positions and velocities of particles
positions = repmat(lb, nParticles, 1) + rand(nParticles, nDims) .* repmat(ub - lb, nParticles, 1);
velocities = zeros(nParticles, nDims);

% Initialize personal best positions and objective function values
pBestPositions = positions;
pBestValues = inf(nParticles, 1);

% Initialize global best position and objective function value
gBestValue = inf;
gBestPosition = zeros(1, nDims);

% Main Optimization loop
for iter = 1:maxIter
    % Evaluate objective function values for each particle
    values = fun(positions);
    
    % Update personal best positions and values
    updateIndices = values < pBestValues;
    updateIndices = find(updateIndices);
    pBestPositions(updateIndices, :) = positions(updateIndices, :);
    pBestValues(updateIndices) = values(updateIndices);
    
    % Update global best position and value
    [minValue, minIndex] = min(pBestValues);
    if minValue < gBestValue
        gBestValue = minValue;
        gBestPosition = pBestPositions(minIndex, :);
    end
    
    % Update velocities and positions
    inertiaWeight = 0.7;
    cognitiveWeight = 1.5;
    socialWeight = 1.5;
    
    r1 = rand(nParticles, nDims);
    r2 = rand(nParticles, nDims);
    
    velocities = inertiaWeight * velocities + cognitiveWeight * r1 .* (pBestPositions - positions) + socialWeight * r2 .* (repmat(gBestPosition, nParticles, 1) - positions);
    positions = positions + velocities;
    
    % Clip positions to within bounds
    positions = max(positions, lb);
    positions = min(positions, ub);
    
    % Display iteration information
    disp(['Iteration ', num2str(iter), ', Best Value: ', num2str(gBestValue)]);
end

% Display final result
fprintf('\nOptimal solution:');
disp(gBestPosition);
disp('Optimal function value:');
disp(gBestValue);
