% Provided data
distance = [0, 0.40000001, 0.80000001, 1.2, 1.6, 2]; % X-axis: distance
temperature = [0, -0.92959797, -1.141946, -1.186126, -1.172345, -1.1385241]; % Y-axis: temperature

% Create the plot
figure;
plot(distance, temperature, '-o', 'LineWidth', 2, 'MarkerSize', 2); % Adjust 'MarkerSize' for smaller markers
grid on;
xlabel('Distance'); % Label for the x-axis
ylabel('Temperature'); % Label for the y-axis
title('Temperature vs Distance');