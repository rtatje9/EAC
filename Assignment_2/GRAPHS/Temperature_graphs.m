% Mesh: 1x1
distance_1x1 = [0, 2]; % X-axis: distance
temperature_1x1 = [0, -1.691057]; % Y-axis: temperature

% Mesh: 5x5
distance_5x5 = [0, 0.40000001, 0.80000001, 1.2, 1.6, 2]; % X-axis: distance
temperature_5x5 = [0, -0.92959797, -1.141946, -1.186126, -1.172345, -1.1385241]; % Y-axis: temperature

% Mesh: 10x10
distance_10x10 = [0, 0.2, 0.40000001, 0.60000002, 0.80000001, 1, 1.2, 1.4, 1.6, 1.8, 2]; % X-axis: distance
temperature_10x10 = [0, -0.63847899, -0.89456898, -1.054333, -1.137543, -1.17135, -1.173138, -1.156141, -1.140487, -1.125789, -1.119251]; % Y-axis: temperature

% Mesh: 30x30
distance_30x30 = [0, 0.0666667, 0.133333, 0.2, 0.26666701, 0.33333299, 0.40000001, 0.466667, 0.533333, 0.60000002, ...
                  0.66666698, 0.73333299, 0.80000001, 0.86666697, 0.93333298, 1, 1.0666699, 1.13333, 1.2, ...
                  1.26667, 1.33333, 1.4, 1.46667, 1.53333, 1.6, 1.66667, 1.73333, 1.8, 1.86667, 1.9333301, 2];
temperature_30x30 = [0, -0.305392, -0.480625, -0.62011403, -0.73141199, -0.822492, -0.89810902, -0.96077102, -1.012302, ...
                     -1.054671, -1.089301, -1.116519, -1.137682, -1.15326, -1.164349, -1.17094, -1.173826, -1.173617, ...
                     -1.1705869, -1.165571, -1.158374, -1.149794, -1.140412, -1.130795, -1.121429, -1.113026, ...
                     -1.1060261, -1.102041, -1.09901, -1.0971839, -1.096542];

% Plot individual graphs
figure(1);
plot(distance_1x1, temperature_1x1, '-o', 'LineWidth', 1.2, 'MarkerSize', 2);
grid on;
xlabel('Distance'); ylabel('Temperature');
title('Temperature vs Distance (Mesh: 1x1)');

figure(2);
plot(distance_5x5, temperature_5x5, '-o', 'LineWidth', 1.2, 'MarkerSize', 2);
grid on;
xlabel('Distance'); ylabel('Temperature');
title('Temperature vs Distance (Mesh: 5x5)');

figure(3);
plot(distance_10x10, temperature_10x10, '-o', 'LineWidth', 1.2, 'MarkerSize', 2);
grid on;
xlabel('Distance'); ylabel('Temperature');
title('Temperature vs Distance (Mesh: 10x10)');

figure(4);
plot(distance_30x30, temperature_30x30, '-o', 'LineWidth', 1.2, 'MarkerSize', 2);
grid on;
xlabel('Distance'); ylabel('Temperature');
title('Temperature vs Distance (Mesh: 30x30)');

% Final graph with all lines
figure(5);
hold on;
plot(distance_1x1, temperature_1x1, '-o', 'LineWidth', 1.2, 'MarkerSize', 2, 'DisplayName', 'Mesh: 1x1');
plot(distance_5x5, temperature_5x5, '-o', 'LineWidth', 1.2, 'MarkerSize', 2, 'DisplayName', 'Mesh: 5x5');
plot(distance_10x10, temperature_10x10, '-o', 'LineWidth', 1.2, 'MarkerSize', 2, 'DisplayName', 'Mesh: 10x10');
plot(distance_30x30, temperature_30x30, '-o', 'LineWidth', 1.2, 'MarkerSize', 2, 'DisplayName', 'Mesh: 30x30');
grid on;
xlabel('Distance'); ylabel('Temperature');
title('Temperature vs Distance (All Mesh Sizes)');
legend('show'); % Show legend
hold off;