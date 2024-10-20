function K = AssemblyKnon(COOR,CN,d_k,AreaFUN,DerStressFUN);

    nelem = size(CN,1); % Number of elements as the number of rows of the connectivty matrix
    nnode = size(COOR,1); % Number of umber of nodes as it is the number of rows of points in the coordinates
    nnodeE = size(CN,2); % Number of nodes per element as it is the number of columns
    K = zeros(nnode,nnode); % To not store the zeros in the matrix

    for e=1:nelem
        % Element matrix
        NODES_e = CN(e,:); % Obtain initial and final nodes of the element e
        COOR_e = COOR(NODES_e); % Corresponding coordinates to the element
        x1=COOR_e(1); % Node 1
        x2=COOR_e(2); % Node 2
        he = x2-x1; % Element longitude
        Be = 1/he*[-1, 1]; % Matrix 
        d_k_elem = d_k(NODES_e,1);
        Strain = Be * d_k_elem;
        A = AreaFUN((x2+x1)/2);
        E = DerStressFUN(Strain);
        % Elemental matrix
        Ke = (A*E)/he*[1 -1; -1 1];
        
        % Assembly
        % Extract global indices for the current element
        A = CN(e, :); % Global indices for 'a'
        B = CN(e, :); % Global indices for 'b'
        
        % Add the local stiffness matrix components to the global stiffness matrix
        K(A, B) = K(A, B) + Ke;
    end

end