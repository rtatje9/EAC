function Me = ComputeMeMatrix(dens,weig,dershapef,shapef, Xe) ;

ndim = size(Xe,1) ; ngaus = length(weig) ; nnodeE = size(Xe,2)  ;  
Me = zeros(nnodeE*ndim,nnodeE*ndim) ; 
for  g = 1:ngaus
    % Matrix of derivatives for Gauss point "g"
    BeXi = dershapef(:,:,g) ; 
    NeSCL=shapef(g,:);
    Ne=StransfN(NeSCL,ndim);
    % Jacobian Matrix 
    Je = Xe*BeXi' ; 
    % Jacobian 
    detJe = det(Je) ; 
    Me = Me + weig(g)*(detJe*Ne'*dens*Ne) ; 
end
