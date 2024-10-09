function f = AssemblyF(COOR, CN)   
    % COOR: Coordinates matrix, CN: Element connectivity matrix
    nnode = size(COOR,1); % Number of umber of nodes as it is the number of rows of points in the coordinates
    %Element force
    Fe = COMPUTE_Fe_FORCE(f,N....); % The functions differs depending on the initial force expresion
    for a = i:nnode % e are rows and a are columns
        A = CN(e,a)
        Ff(A) = Ff(A) + Fe(a); 
    end
end

