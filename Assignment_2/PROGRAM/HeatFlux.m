function [qFluxGlobal, gaussPositions] = HeatFlux(COOR, CN, ElementType, GlobalConductivity, temperatureVector)
% This function computes the heat flux vector at each Gauss point for all elements.
%
% Input:
% COOR - Coordinates of the nodes (nnode x ndim)
% CN - Connectivity matrix (nelem x nnodeE)
% ElementType - Type of finite element
% GlobalConductivity - Conductivity matrices for all elements
% temperatureVector - Nodal temperature vector (nnode x 1)
%
% Output:
% qFluxGlobal - Heat flux vector at Gauss points (ngauss*ndim x nelem)
% gaussPositions - Positions of the Gauss points

% Problem dimensions
numNodes = size(COOR, 1);
numDims = size(COOR, 2);
numElements = size(CN, 1);
nodesPerElement = size(CN, 2);

% Initialize global heat flux vector
qFluxGlobal = zeros(8, numElements);

% Define the integrand type and compute shape functions
integrandType = 'K';
[weights, gaussPositions, shapeFunctions, shapeFunctionDerivatives] = ComputeElementShapeFun(ElementType, nodesPerElement, integrandType);

% Loop over each element to compute heat fluxes
for elemIdx = 1:numElements
    % Nodes and temperatures of the current element
    elementNodes = CN(elemIdx, :);
    localTemperatures = temperatureVector(elementNodes);
    localConductivity = GlobalConductivity(:, :, elemIdx);
    elementCoords = COOR(elementNodes, :)';

    % Element-specific dimensions
    numDims = size(elementCoords, 1);
    nodesPerElement = size(elementCoords, 2);
    numGaussPoints = length(weights);

    % Loop over Gauss points to compute local heat flux
    for gaussIdx = 1:numGaussPoints
        % Derivative matrix for current Gauss point
        localDerivatives = shapeFunctionDerivatives(:, :, gaussIdx);

        % Jacobian matrix and determinant
        jacobianMatrix = elementCoords * localDerivatives';
        detJacobian = det(jacobianMatrix);

        % Derivatives in physical space
        physicalDerivatives = inv(jacobianMatrix)' * localDerivatives;

        % Compute heat flux
        localHeatFlux = -localConductivity * physicalDerivatives * localTemperatures;

        % Store in global array
        startIdx = (gaussIdx - 1) * numDims + 1;
        endIdx = gaussIdx * numDims;
        qFluxGlobal(startIdx:endIdx, elemIdx) = localHeatFlux;
    end
end
end