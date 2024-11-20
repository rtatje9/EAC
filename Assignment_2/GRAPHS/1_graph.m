% Provided data
distance = [0, 2]; % X-axis: distance
temperature = [0, -1.691057]; % Y-axis: temperature

% Create the plot
figure;
plot(distance, temperature, '-o', 'LineWidth', 2);
grid on;
xlabel('Distance'); % Label for the x-axis
ylabel('Temperature'); % Label for the y-axis
title('Temperature vs Distance');