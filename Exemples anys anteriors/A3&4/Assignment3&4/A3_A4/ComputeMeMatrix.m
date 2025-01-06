function Me = ComputeMeMatrix(dens,weig,dershapef,shapef,Xe)
ndim = size(Xe,1) ; ngaus = length(weig) ; nnodeE = size(Xe,2)  ;  
Me = zeros(nnodeE*ndim,nnodeE*ndim) ; 
for  g = 1:ngaus
    BeXi = dershapef(:,:,g) ;
    NeSCL=shapef(g,:);
    Ne = StransfN(NeSCL,ndim) ;
    Je = Xe*BeXi' ; 
    detJe = det(Je) ;
    Me = Me + weig(g)*(detJe*Ne'*dens*Ne) ; 
end
end