function [Residual,STRAIN,STRESS] = AssemblyFint(COOR,CN,d_k,stressFUN,AreaFUN)

%%% INPUTS %%%
% COOR --> Coordinates vector
% CN --> Connectivity matrix
% d_k --> Previous displacements
% stressFUN & AreaFUN --> Functions of area and stress (sigma)


    nnode = size(COOR,1); % Number of nodes as it is the number of rows of points in the coordinates
    n_elem = size(CN,1);

    Residual = zeros(nnode,1); % One residual equation for every element
    STRAIN = zeros(n_elem, 1); % One strain for every element
    STRESS = zeros(n_elem, 1); % One stress for every element

    for e=1:n_elem
        NODES_e = CN(e,:); % Obtain initial and final nodes of the element e
        COOR_e = COOR(NODES_e); % Corresponding coordinates to the element e
        x1=COOR_e(1); % Node 1
        x2=COOR_e(2); % Node 2
        he = x2-x1; % Element longitude
        d_k_elem = d_k(NODES_e,1); % Previous elements solution
        Be = 1/he*[-1, 1]; % Matrix 
        A_e = AreaFUN((x2+x1)/2); % Area of the element (Average of nodes)
        Strain_e = Be*d_k_elem; % Strain of the element
        Stress_e = stressFUN(Strain_e); % Stress of the element
        F_e = he*(Be'*A_e*Stress_e); % Elemental internal force
        

        Residual(NODES_e) = Residual(NODES_e) + F_e;

        STRAIN(e) = Strain_e;
        STRESS(e) = Stress_e;
    end

end




