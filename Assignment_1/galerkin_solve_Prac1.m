function [u] = galerkin_solve_Prac1(N,f,b,g,L,rho);
    syms x
    N_1 = subs(N,1); B = diff(N,x); % Matrix expressions defined in the resolution
    BtB = B.'*B; K = int(BtB,0,L)-rho*int(N.'*N,0,L);
    F = int(N.'*f,0,1)+N_1.'*b;
    r = 1; l = 2:length(N); % Freedom degrees. known/unkown coeficients
    dl = K(l,l)\(F(l)+K(l,r)*g); % Solving equations system
    u = -g + N(l)*dl; %Problem solution --> u = N(1)*d1 + 
end