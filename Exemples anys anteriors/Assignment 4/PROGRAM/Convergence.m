% Convergence section

%%  1. Calculate analytical prediction by Strength of Materials theory

% Define parameters
x = linspace(0,2,10000); %m
E= 70e6; %MPa
I = 2.83e-4; % m^4
omeg = -125; % kN/m
L = 2; %m

% Calculate analytical displacement
y=(omeg)/(24*E*I)*(x.^4+6*L^2*x.^2-4*L*x.^3);


%% 2. Define mesh plot coordinates

% Case 1: 2 divisions

coord_1 = [0, 0;
1, -0.00086799997;
2, -0.0024580001];

% Case 2: 10 divisions

coord_2 = [0, 0;
0.2, -0.000239;
0.40000001, -0.00080500002;
0.60000002, -0.001642;
0.80000001, -0.0026809999;
1, -0.0038689999;
1.2, -0.0051589999;
1.4, -0.006513;
1.6, -0.0079009999;
1.8, -0.0093019996;
2, -0.010703];

% Case 3: 15 divisions

coord_3 = [0, 0;
0.133333, -0.000137;
0.26666701, -0.00043700001;
0.40000001, -0.00089600001;
0.533333, -0.001482;
0.66666698, -0.002177;
0.80000001, -0.002961;
0.93333298, -0.003817;
1.0666699, -0.0047280001;
1.2, -0.005682;
1.33333, -0.0066669998;
1.46667, -0.0076720002;
1.6, -0.008688;
1.73333, -0.0097110001;
1.86667, -0.010734;
2, -0.011756];

% Case 4: 20 divisions

coord_4 = [0, 0;
0.1, -9.2000002e-05;
0.2, -0.00027799999;
0.30000001, -0.00056399999;
0.40000001, -0.00093500002;
0.5, -0.001381;
0.60000002, -0.001893;
0.69999999, -0.0024610001;
0.80000001, -0.0030789999;
0.89999998, -0.0037390001;
1, -0.004433;
1.1, -0.0051549999;
1.2, -0.0059000002;
1.3, -0.0066630002;
1.4, -0.0074390001;
1.5, -0.0082240002;
1.6, -0.0090140002;
1.7, -0.0098080002;
1.8, -0.010603;
1.9, -0.011398;
2, -0.012191];

%% 3. Plot to see the convergence
figure
hold on;
grid on;
plot(x,y, coord_1(:,1),coord_1(:,2), coord_2(:,1),coord_2(:,2), coord_3(:,1),coord_3(:,2), coord_4(:,1),coord_4(:,2));
xlabel('Distance along the edges of the top surface (m)')
ylabel('Vertical displacement (m)')
title('Convergence between the program and the analytical prediction')
legend('Analytical Prediction', 'Case 1: 2 divisions', 'Case 2: 10 divisions', 'Case 3: 15 divisions', 'Case 4: 20 divisions')