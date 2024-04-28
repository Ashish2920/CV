% Parameters
TARGET_WORD = 'hello';
POPULATION_SIZE = 100;
MUTATION_RATE = 0.1;
MAX_GENERATIONS = 1000;
fprintf('Target word: %s\n', TARGET_WORD);
fprintf('Population Size: %d\n', POPULATION_SIZE);
fprintf('Mutation Rate: %f\n', MUTATION_RATE);
fprintf('Maximum Generations: %d\n\n', MAX_GENERATIONS);

% Initialize population
population = cell(POPULATION_SIZE, 1);
for i = 1:POPULATION_SIZE
    population{i} = generateRandomWord(length(TARGET_WORD));
end

% Main loop
for generation = 1:MAX_GENERATIONS
    % Calculate fitness for each individual
    fitness_scores = zeros(POPULATION_SIZE, 1);
    for i = 1:POPULATION_SIZE
        fitness_scores(i) = calculateFitness(population{i}, TARGET_WORD);
    end
    
    % Check if target word is found
    [best_fitness, idx] = max(fitness_scores);
    best_word = population{idx};
    if strcmp(best_word, TARGET_WORD)
        fprintf('Generation %d: Best Word = %s, Fitness = %d\n', generation, best_word, best_fitness);
        fprintf('Target word found: %s\n', best_word);
        break;
    end
    
    % Selection: Roulette wheel selection
    total_fitness = sum(fitness_scores);
    probabilities = fitness_scores / total_fitness;
    selected_indices = randsample(1:POPULATION_SIZE, POPULATION_SIZE, true, probabilities);
    selected_population = population(selected_indices);
    
    % Crossover and Mutation
    new_population = cell(POPULATION_SIZE, 1);
    for i = 1:2:POPULATION_SIZE
        parent1 = selected_population{i};
        parent2 = selected_population{i+1};
        point = randi(length(TARGET_WORD) - 1) + 1;
        child1 = [parent1(1:point) parent2(point+1:end)];
        child2 = [parent2(1:point) parent1(point+1:end)];
        % Mutation
        if rand < MUTATION_RATE
            mutate_index = randi(length(TARGET_WORD));
            child1(mutate_index) = char(randi([97, 122])); % random lowercase letter
        end
        if rand < MUTATION_RATE
            mutate_index = randi(length(TARGET_WORD));
            child2(mutate_index) = char(randi([97, 122])); % random lowercase letter
        end
        new_population{i} = child1;
        new_population{i+1} = child2;
    end
    population = new_population;
    % Print best word in each generation
    fprintf('Generation %d: Best Word = %s, Fitness = %d\n', generation, best_word, best_fitness);
end

if generation == MAX_GENERATIONS
    fprintf('Maximum generations reached. Target word not found.\n');
end

% Function to generate a random word of given length
function word = generateRandomWord(length)
    letters = 'abcdefghijklmnopqrstuvwxyz';
    word = letters(randi(numel(letters), [1, length]));
end

% Function to calculate fitness of a word
function fitness = calculateFitness(word, target_word)
    fitness = sum(word == target_word);
end
