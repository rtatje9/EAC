
function M = ComputeM(COOR, CN, TypeElement, densglo)
% This subroutine returns the global mass matrix M (ndim*nnode x ndim*nnode)
% Inputs:
% - COOR: Coordinate matrix (nnode x ndim)
% - CN: Connectivity matrix (nelem x nnodeE)
% - TypeElement: Type of finite element (e.g., quadrilateral)
% - densglo: Array of density values for each element

% Load test data if no arguments are provided
if nargin == 0
    load('tmp1.mat')
end

% Problem dimensions
nnode = size(COOR, 1); 
ndim = size(COOR, 2); 
nelem = size(CN, 1); 
nnodeE = size(CN, 2); 

% Shape function routines for integration
TypeIntegrand = 'K';
[weig, posgp, shapef, dershapef] = ComputeElementShapeFun(TypeElement, nnodeE, TypeIntegrand);

% Initialize the global mass matrix as sparse
M = sparse([], [], [], nnode * ndim, nnode * ndim, nnodeE * ndim * nelem);

% Loop over elements to compute and assemble the mass matrix
for e = 1:nelem
    % Extract density for element "e"
    dens = densglo(e);
    
    % Element connectivity and coordinates
    CNloc = CN(e, :);         % Nodes of element "e"
    Xe = COOR(CNloc, :)';     % Coordinates of these nodes

    % Compute the element mass matrix
    Me = ComputeMeMatrix(dens, weig, dershapef, shapef, Xe);

    % Assembly process: map local indices to global indices
    indices = zeros(nnodeE * ndim, 1);
    for node = 1:nnodeE
        for d = 1:ndim
            indices((node - 1) * ndim + d) = (CN(e, node) - 1) * ndim + d;
        end
    end
    
    % Add the element matrix to the global matrix
    M(indices, indices) = M(indices, indices) + Me;

    % Display progress every 10 elements
    if mod(e, 10) == 0
        disp(['e=', num2str(e)])
    end

end




   

