function [weights, gaussPoints, shapeFuncs, shapeFuncDerivs] = Hexaedra8NInPoints()

% Define dimensions and constants
numDims = 3;
numNodesPerElem = 2^numDims;
weights = ones(1, numNodesPerElem);
numGaussPoints = length(weights);

% Define signs for Gauss points
signMatrix = [-1  1  1 -1 -1  1  1 -1;   % Signs for xi
              -1 -1  1  1 -1 -1  1  1;   % Signs for eta
              -1 -1 -1 -1  1  1  1  1];  % Signs for zeta

gaussPoints = (1 / sqrt(3)) * signMatrix;

% Initialize shape functions and derivatives
shapeFuncs = zeros(numGaussPoints, numNodesPerElem);
shapeFuncDerivs = zeros(numDims, numNodesPerElem, numGaussPoints);

% Compute shape functions and their derivatives at each Gauss point
for pointIdx = 1:numGaussPoints
    xiCoord = gaussPoints(1, pointIdx);
    etaCoord = gaussPoints(2, pointIdx);
    zetaCoord = gaussPoints(3, pointIdx);

    % Compute shape functions
    shapeFuncs(pointIdx, :) = (1 / numNodesPerElem) * [
        (1 - xiCoord) * (1 - etaCoord) * (1 - zetaCoord), ...
        (1 + xiCoord) * (1 - etaCoord) * (1 - zetaCoord), ...
        (1 + xiCoord) * (1 + etaCoord) * (1 - zetaCoord), ...
        (1 - xiCoord) * (1 + etaCoord) * (1 - zetaCoord), ...
        (1 - xiCoord) * (1 - etaCoord) * (1 + zetaCoord), ...
        (1 + xiCoord) * (1 - etaCoord) * (1 + zetaCoord), ...
        (1 + xiCoord) * (1 + etaCoord) * (1 + zetaCoord), ...
        (1 - xiCoord) * (1 + etaCoord) * (1 + zetaCoord)
    ];

    % Compute derivatives of shape functions
    shapeFuncDerivs(:, :, pointIdx) = (1 / numNodesPerElem) .* [
        signMatrix(1, :) .* [(1 - etaCoord) * (1 - zetaCoord), (1 - etaCoord) * (1 - zetaCoord), ...
                             (1 + etaCoord) * (1 - zetaCoord), (1 + etaCoord) * (1 - zetaCoord), ...
                             (1 - etaCoord) * (1 + zetaCoord), (1 - etaCoord) * (1 + zetaCoord), ...
                             (1 + etaCoord) * (1 + zetaCoord), (1 + etaCoord) * (1 + zetaCoord)];
        signMatrix(2, :) .* [(1 - xiCoord) * (1 - zetaCoord), (1 + xiCoord) * (1 - zetaCoord), ...
                             (1 + xiCoord) * (1 - zetaCoord), (1 - xiCoord) * (1 - zetaCoord), ...
                             (1 - xiCoord) * (1 + zetaCoord), (1 + xiCoord) * (1 + zetaCoord), ...
                             (1 + xiCoord) * (1 + zetaCoord), (1 - xiCoord) * (1 + zetaCoord)];
        signMatrix(3, :) .* [(1 - xiCoord) * (1 - etaCoord), (1 + xiCoord) * (1 - etaCoord), ...
                             (1 + xiCoord) * (1 + etaCoord), (1 - xiCoord) * (1 + etaCoord), ...
                             (1 - xiCoord) * (1 - etaCoord), (1 + xiCoord) * (1 - etaCoord), ...
                             (1 + xiCoord) * (1 + etaCoord), (1 - xiCoord) * (1 + etaCoord)]
    ];
end

end





 

