fprintf("Particle Swarm Optimization Algorithm (Rosenbrock Function): \n")
% Define the Objective function (Rosenbrock Function)
rosenbrock = @(x) (1 - x(1))^2 + 100*(x(2) - x(1)^2)^2;

% PSO parameters
dimension = 2; % Number of dimensions
numParticles = 20; % Number of particles in the swarm
maxIterations = 80; % Maximum number of iterations
w = 0.7; % inertia weight
c1 = 1.5; % cognitive parameter
c2 = 1.5; % social parameter
fprintf("Number of dimension: %d\n",dimension);
fprintf("Number of particles in Swarm: %d\n",numParticles);
fprintf("Maximum number of Iterations: %d\n",maxIterations);
fprintf("Inertia Weight: %f\n",w);
fprintf("Cognitive parameter: %f\n",c1);
fprintf("Social parameter: %f\n\n",c2);

% Initialize particles
particles.position = rand(numParticles, dimension) * 10 - 5; % Random initialization between -5 and 5
particles.velocity = zeros(numParticles, dimension);
particles.bestPosition = particles.position;
particles.bestValue = inf(1, numParticles);
globalBestPosition = zeros(1, dimension);
globalBestValue = inf;

% PSO optimization loop
for iter = 1:maxIterations
    % Update particle positions and velocities
    r1 = rand(numParticles, dimension);
    r2 = rand(numParticles, dimension);
    particles.velocity = w * particles.velocity + c1 * r1 .* (particles.bestPosition - particles.position) + c2 * r2 .* (repmat(globalBestPosition, numParticles, 1) - particles.position);
    particles.position = particles.position + particles.velocity;
    
    % Update personal best positions
    currentValues = zeros(1, numParticles);
    for i = 1:numParticles
        currentValues(i) = rosenbrock(particles.position(i,:));
    end
    
    improvedParticles = currentValues < particles.bestValue;
    particles.bestPosition(improvedParticles, :) = particles.position(improvedParticles, :);
    particles.bestValue(improvedParticles) = currentValues(improvedParticles);
    
    % Update global best position
    [minValue, minIndex] = min(particles.bestValue);
    if minValue < globalBestValue
        globalBestValue = minValue;
        globalBestPosition = particles.bestPosition(minIndex, :);
    end
    
    % Display current iteration and best value found
    disp(['Iteration: ', num2str(iter), ', Best Value: ', num2str(globalBestValue)]);
end

fprintf('Optimization complete.\n\n');
disp(['Global Minimum found at: ', num2str(globalBestPosition)]);
disp(['Minimum Value: ', num2str(globalBestValue)]);
