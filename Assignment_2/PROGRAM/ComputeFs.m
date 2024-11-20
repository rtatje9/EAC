function Fs = ComputeFs(COOR,CN,TypeElement, fNOD) ; 
% This subroutine   returns the  heat source contribution (Fs)    to the
% global flux vector. Inputs
% --------------
% 1. Finite element mesh 
% -------------------
% COOR: Coordinate matrix (nnode x ndim)
% CN: Connectivity matrix (nelem x nnodeE)
% TypeElement: Type of finite element (quadrilateral,...)
% -----------
% 2. Vector containing the values of the heat source function at the nodes
% of the mesh
% -----------
%  fNOD (nnode x 1)  %  
%%%%
 
% Dimensions of the problem 
nnode = size(COOR,1); ndim = size(COOR,2); nelem = size(CN,1); nnodeE = size(CN,2) ;     




% Define the type of integrand for computing shape functions
TypeIntegrand = 'RHS';
[weig, posgp, shapef, dershapef] = ComputeElementShapeFun(TypeElement, nnodeE, TypeIntegrand);
Fs = zeros(nnode,1) ;  

% Assembly of the Fs vector
for elemIdx = 1:nelem
    % Nodes of the current element
    elemNodes = CN(elemIdx, :);
    
    % Heat source values at the current element's nodes
    elemHeatSource = fNOD(elemNodes);
    
    % Coordinates of the nodes of the current element
    elemCoords = COOR(elemNodes, :)';
    
    % Compute the local heat source contribution for the element
    localFs = ComputeFseVector(elemHeatSource, weig, shapef, dershapef, elemCoords);
    
    % Assemble the local contributions into the global flux vector
    for localNodeIdx = 1:nnodeE
        Fs(elemIdx) = Fs(elemIdx) + localFs(localNodeIdx);
    end
end