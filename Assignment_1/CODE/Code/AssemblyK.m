function K = AssemblyK(COOR,CN, rho_val) 
    % COOR: Coordinates matrix, CN: Element connectivity matrix
    nelem = size(CN,1); % Number of elements as the number of rows of the connectivty matrix
    nnode = size(COOR,1); % Number of umber of nodes as it is the number of rows of points in the coordinates
    nnodeE = size(CN,2); % Number of nodes per element as it is the number of columns
    K = sparse(nnode,nnode); % To not store the zeros in the matrix
    for e=1:nelem
        % Element matrix
        NODES_e = CN(e,:); % Obtain initial and final nodes of the element e
        COOR_e = COOR(NODES_e); % Corresponding coordinates to the element
        he = COOR_e(2) - COOR_e(1); % Element longitude
        % Elemental matrix
        Ke = 1/he*[1 -1; -1 1] - rho_val*he/6*[2 1; 1 2]; 
        % It has the form Ke = 1/he*[1 -1; -1 1] only in the case of u''+f=0 (and thus has been modified for the case u''+u+f=0).
        
        % Assembly
        % Extract global indices for the current element
        A = CN(e, :); % Global indices for 'a'
        B = CN(e, :); % Global indices for 'b'
        
        % Add the local stiffness matrix components to the global stiffness matrix
        K(A, B) = K(A, B) + Ke;
    end
end