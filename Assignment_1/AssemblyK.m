function K = AssemblyK(COOR,CN) 
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
        Ke = 1/he*[1 -1; -1 1]; % Coefficients matrix (Element stifness matrix). In the practice, the matrix should be accomodated in order to evaluate the right EDO
        % Assembly
        for a = 1:nnodeE
            for b = 1:nnodeE % a and b local indexes
                A = CN(e,a); 
                B = CN(e,b); % A and B global indexes
                K(A,B) = K(A,B) + Ke(a,b); % Adding the component of the local stifness mtarix
            end
        end
    end

    %Ff = sparse(nnode,1);
end