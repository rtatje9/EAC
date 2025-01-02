clc;
clear;
close all;

% Load input data files
load('DATA_prac3.mat');
load('data_M_K.mat');

% Define parameters
num_modes = 25; % Number of modes to compute
num_nodes = size(COOR, 1); % Total number of nodes
dimensions = size(COOR, 2); % Spatial dimensions
free_dofs = 1:num_nodes * dimensions;
free_dofs(DOFr) = []; % Eliminate constrained DOFs

% Extract reduced mass and stiffness matrices
mass_matrix = M(free_dofs, free_dofs);
stiffness_matrix = K(free_dofs, free_dofs);

% Compute undamped natural frequencies and mode shapes
[mode_shapes, natural_frequencies] = UndampedFREQ(mass_matrix, stiffness_matrix, num_modes);

% Display the first 25 natural frequencies (analytical calculation)
fprintf('Natural frequencies (Hz) of the first 25 modes:\n');
for i = 1:num_modes
    fprintf('Mode %d: %.2f Hz\n', i, natural_frequencies(i) / (2 * pi));
end

damping_ratio = 0.01; % Damping ratio
time_steps = 40;
time_vector = linspace(0, time_steps * 2 * pi / natural_frequencies(5), 500);

%% Plot: Mode Amplitudes
figure;
amplitudes = zeros(1, num_modes);
for mode_idx = 1:num_modes
    amplitudes(mode_idx) = abs(mode_shapes(:, mode_idx)' * mass_matrix * d(free_dofs));
end
bar(amplitudes);
xlabel('Mode Number');
ylabel('Amplitude');
title('Mode Shapes: Amplitudes');

%% Plot: Frequency vs Amplitude
figure;
frequencies_str = strings(1, num_modes);
for mode_idx = 1:num_modes
    amplitudes(mode_idx) = abs(mode_shapes(:, mode_idx)' * mass_matrix * d(free_dofs));
    frequencies_str{mode_idx} = num2str(round(natural_frequencies(mode_idx)));
end
bar(amplitudes);
xticks(1:num_modes);
xticklabels(frequencies_str);
xlabel('Frequency \omega [rad/s]');
ylabel('Amplitude');
title('Frequency vs Mode Amplitudes');

%% Plot: Frequency (Hz) vs Amplitude
figure;
hz_frequencies = strings(1, num_modes);
for mode_idx = 1:num_modes
    amplitudes(mode_idx) = abs(mode_shapes(:, mode_idx)' * mass_matrix * d(free_dofs));
    hz_frequencies{mode_idx} = num2str(round(natural_frequencies(mode_idx) / (2 * pi)));
end
bar(amplitudes);
xticks(1:num_modes);
xticklabels(hz_frequencies);
xlabel('Frequency [Hz]');
ylabel('Amplitude');
title('Frequency (Hz) vs Mode Amplitudes');

% Post-process results in GID
GidPostProcessModes(COOR, CN, TypeElement, mode_shapes, posgp', NameFileMesh, DATA, free_dofs);



%% Dynamic Displacement Calculation
num_time_steps = length(time_vector);
displacement_dynamic = zeros(length(free_dofs), num_time_steps);
for time_idx = 1:num_time_steps
    t = time_vector(time_idx);
    for mode_idx = 1:num_modes
        displacement_dynamic(:, time_idx) = displacement_dynamic(:, time_idx) + mode_shapes(:, mode_idx) * ...
            (exp(-damping_ratio * natural_frequencies(mode_idx) * t) * (amplitudes(mode_idx) * cos(natural_frequencies(mode_idx) * t) + ...
            (damping_ratio * natural_frequencies(mode_idx) * amplitudes(mode_idx)) / natural_frequencies(mode_idx) * sin(natural_frequencies(mode_idx) * t)));
    end
end

total_displacement = zeros(num_nodes * 3, num_time_steps);
for idx = 1:num_time_steps
    total_displacement(free_dofs, idx) = displacement_dynamic(:, idx);
end
GidPostProcessDynamic(COOR, CN, TypeElement, total_displacement, NAME_INPUT_DATA, posgp', NameFileMesh, time_vector');

%% Beam Properties and Natural Frequency Calculation
beam_length = 2; % Length of the beam [m]
material_density = 2700; % Density [kg/m^3]
youngs_modulus = 70e9; % Young's modulus [Pa]
beam_thickness = 0.05; % Thickness of the beam [m]
beam_width = 0.25; % Width of the beam [m]

cross_section_area = beam_width^2 - (beam_width - 2 * beam_thickness)^2;
second_moment_inertia = (1 / 12) * (beam_width^4 - (beam_width - 2 * beam_thickness)^4);


first_mode_constant = 1.875;
first_natural_frequency = (first_mode_constant^2) / (2 * pi * beam_length^2) * sqrt((youngs_modulus * second_moment_inertia) / (material_density * cross_section_area));
angular_frequency_first_mode = first_natural_frequency * 2 * pi;

% Display calculated natural frequency
fprintf('First natural frequency (Hz): %.2f\n', first_natural_frequency);
fprintf('First angular frequency (rad/s): %.2f\n', angular_frequency_first_mode);



