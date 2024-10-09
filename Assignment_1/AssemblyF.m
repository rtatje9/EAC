function F = AssemblyF(COOR, CN,s,L,g)   
    % COOR: Coordinates matrix, CN: Element connectivity matrix
    nnode = size(COOR,1); % Number of umber of nodes as it is the number of rows of points in the coordinates
    n_elem = size(CN,1);
    %Element force
    F = sparse (nnode,1);
    for n=1:n_elem
        NODES_e = CN(n,:); % Obtain initial and final nodes of the element e
        COOR_e = COOR(NODES_e); % Corresponding coordinates to the element
        he = COOR_e(2) - COOR_e(1); % Element longitude
        x1=COOR_e(1);
        x2=COOR_e(2);
        Fe=-(s*he/(12*L^2))*[3*x1^2+2*x1*x2+x2^2 ; x1^2+2*x1*x2+3*x2^2];
        F(NODES_e)=F(NODES_e)+Fe;
    end
    F(n+1)=F(n+1)+g*pi^2/L;
end

