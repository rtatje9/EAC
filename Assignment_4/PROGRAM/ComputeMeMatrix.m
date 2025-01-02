function Me = ComputeMeMatrix(dens, weig, dershapef, shapef, Xe)
% Computes the element mass matrix (Me)
% Inputs:
% - dens: Density of the material
% - weig: Vector of Gauss weights (1 x ngaus)
% - dershapef: Array with the derivatives of shape functions (ndim x nnodeE x ngaus)
% - shapef: Shape functions evaluated at Gauss points (ngaus x nnodeE)
% - Xe: Global coordinates of the nodes of the element (ndim x nnodeE)

% Dimensions
ndim = size(Xe, 1); % Number of spatial dimensions
ngaus = length(weig); % Number of Gauss points
nnodeE = size(Xe, 2); % Number of nodes per element

% Initialize the mass matrix
Me = zeros(nnodeE * ndim, nnodeE * ndim);

for g = 1:ngaus
    % Shape functions at Gauss point "g"
    NeSCL = shapef(g, :); % Scalar shape functions
    Ne = StransfN(NeSCL, ndim); % Expand to vector format

    % Jacobian matrix
    BeXi = dershapef(:, :, g); % Derivatives of shape functions
    Je = Xe * BeXi'; % Compute Jacobian matrix
    detJe = det(Je); % Determinant of Jacobian

    % Mass matrix contribution
    Me = Me + weig(g) * detJe * (Ne' * dens * Ne);
end
end