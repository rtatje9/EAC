% Load data from the provided file
load('INFO_FE.mat'); % Replace with the correct filename if needed

% Initialize reaction forces
Fx = 0;
Fy = 0;
Fz = 0;

% Initialize moments
Mx = 0;
My = 0;
Mz = 0;

% Reshape reaction forces into a matrix [n x 3]
Fr = [React(1:3:end).'; React(2:3:end).'; React(3:3:end).'].';    

% Reference point for moment calculation
ref_point = [0 .25/2 -0.25/2]; 

% Calculate resultant reactions and moments
for i = 1:size(Fr, 1)
    Fx = Fx + Fr(i, 1);
    Fy = Fy + Fr(i, 2);
    Fz = Fz + Fr(i, 3);
    
    displacement = [(COOR(i, 1) - ref_point(1)), ...
                    (COOR(i, 2) - ref_point(2)), ...
                    (COOR(i, 3) - ref_point(3))];
    moment = cross(displacement, Fr(i, :));
    
    Mx = Mx + moment(1);
    My = My + moment(2);
    Mz = Mz + moment(3);
end

% Display results
fprintf("\nComputed Reactions:\n\n");
fprintf("  * Fx = %f MN\n", Fx);
fprintf("  * Fy = %f MN\n", Fy);
fprintf("  * Fz = %f MN\n", Fz);
fprintf("  * Mx = %f MNm\n", Mx);
fprintf("  * My = %f MNm\n", My);
fprintf("  * Mz = %f MNm\n", Mz);

% Final reactions vector
Reactions = [Fx, Fy, Fz, Mx, My, Mz];