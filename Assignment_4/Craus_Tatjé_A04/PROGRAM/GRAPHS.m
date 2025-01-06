clc
clear
close all
% Data for Mesh_1
x1 = [0, 1, 2];
y1 = [0, -0.000868, -0.002458];

% Data for Mesh_2
x2 = [0, 0.2, 0.4, 0.6, 0.8, 1, 1.2, 1.4, 1.6, 1.8, 2];
y2 = [0, -0.000239, -0.000805, -0.001642, -0.002681, -0.003869, ...
      -0.005159, -0.006513, -0.007901, -0.009302, -0.010703];

% Data for Mesh_3
x3 = [0, 0.133333, 0.266667, 0.4, 0.533333, 0.666667, 0.8, 0.933333, ...
      1.06667, 1.2, 1.33333, 1.46667, 1.6, 1.73333, 1.86667, 2];
y3 = [0, -0.000136, -0.000437, -0.000895, -0.001482, -0.002177, ...
      -0.002961, -0.003816, -0.004728, -0.005682, -0.006667, ...
      -0.007671, -0.008688, -0.009711, -0.010734, -0.011756];

% Data for Mesh_4
x4 = [0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1, 1.1, 1.2, ...
      1.3, 1.4, 1.5, 1.6, 1.7, 1.8, 1.9, 2];
y4 = [0, -9.4e-05, -0.000281, -0.00057, -0.000944, -0.001392, ...
      -0.001907, -0.002478, -0.003099, -0.003762, -0.004459, ...
      -0.005185, -0.005933, -0.006699, -0.007478, -0.008266, ...
      -0.009059, -0.009856, -0.010654, -0.011451, -0.012248];

%Theoretical displacements
L = 2;                          % Beam longitude
h = 0.25;                       % Width and height
e = 0.05;                       % Thickness
E = 70e9;                       % Young modulus
I = 1/12 * (h^4-(h-2*e)^4);     % Inertia
t = 5e5;                        % Vertical force
xT = 0:0.001:2;
yT = -h*t*xT.^2/(24.*E.*I).*(xT.^2+6.*L^2-4*L.*xT);


% Plot all Mesh data
figure(1);
hold on;
plot(x1, y1*1e3, '-o', 'LineWidth', 1.2, 'MarkerSize', 2, 'DisplayName', 'Mesh 1');
plot(x2, y2*1e3, '-o', 'LineWidth', 1.2, 'MarkerSize', 2, 'DisplayName', 'Mesh 2');
plot(x3, y3*1e3, '-o', 'LineWidth', 1.2, 'MarkerSize', 2, 'DisplayName', 'Mesh 3');
plot(x4, y4*1e3, '-o', 'LineWidth', 1.2, 'MarkerSize', 2, 'DisplayName', 'Mesh 4');
plot(xT, yT*1e3, 'LineWidth', 1.4, 'MarkerSize', 2, 'DisplayName', 'Analytical Solution');

hold off;

% Graph labels and legend
xlabel('Beam Axis X');
ylabel('vertical displacement');
title('Vertical displacement along the beam');
legend('show');
grid on;