function K = ComputeK(COOR,CN,TypeElement, ConductMglo) ;
%%%%
% This subroutine   returns the global conductance matrix K (nnode x nnode)
% Inputs
% --------------
% 1. Finite element mesh
% -------------------
% COOR: Coordinate matrix (nnode x ndim)
% CN: Connectivity matrix (nelem x nnodeE)
% TypeElement: Type of finite element (quadrilateral,...)
% -----------
% 2. Material
% -----------
%  ConductMglo (ndim x ndim x nelem)  % Array of conductivity matrices
%%%%
 if nargin == 0
     load('tmp1.mat')
 end
 
 
 
 
%% COMPLETE THE CODE ....
%warning('You must program the assembly of the conductance matrix K !!')


% Dimensions of the problem
nnode = size(COOR,1);  % Number of nodes
ndim = size(COOR,2);   % Spatial Dimension of the problem  (2 or 3)
nelem = size(CN,1);   % Number of elements 
nnodeE = size(CN,2) ; %Number of nodes per element 

% Determine Gauss weights, shape functions and derivatives  
TypeIntegrand = 'K'; 
[weig,posgp,shapef,dershapef] = ComputeElementShapeFun(TypeElement,nnodeE,TypeIntegrand) ; 

%

% Assembly of matrix K
% ----------------
K = sparse(nnode,nnode) ;
% ......
% Loop through each element to assemble the global conductance matrix
% Assembly of the K matrix
for elem = 1:nelem
    % Nodes of the current element
    elemNodes = CN(elem, :);
    
    % Coordinates of the nodes of the current element
    elemCoords = COOR(elemNodes, :)';
    
    % Conductivity matrix of the current element
    elemConductivity = ConductMglo(:, :, elem);
    
    % Compute the local conductance matrix of the element
    localK = ComputeKeMatrix(elemConductivity, weig, dershapef, elemCoords);
    
    % Assemble into the global matrix
    K(elemNodes, elemNodes) = K(elemNodes, elemNodes) + localK;
end
end

