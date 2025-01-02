function [weig,posgp,shapef,dershapef] = Hexahedra8NInPoints

%code for the shape function routine for hexaedra

weig = [1 1 1 1 1 1 1 1];
posgp=1/sqrt(3)*[-1 -1 -1;
    1 -1 -1;
    1 1 -1;
    -1 1 -1;
    -1 -1 1;
    1 -1 1;
    1 1 1
    -1 1 1]';

ndim=3;
nnodeE=8;
ngaus=length(weig);
shapef=zeros(ngaus,nnodeE);
dershapef=zeros(ndim,nnodeE,ngaus);
for j=1:length(weig)
    xi = posgp(:,j).';
    [Ne, Bex]=Hexahedra8N(xi);
    shapef(j,:)=Ne;
    dershapef(:,:,j)=Bex;
end
end

function [Ne, Bex]=Hexahedra8N(x)
xi=x(1);
eta=x(2);
zeta=x(3);

Ne=1/8*[(1-xi)*(1-eta)*(1-zeta) (1+xi)*(1-eta)*(1-zeta) (1+xi)*(1+eta)*(1-zeta) (1-xi)*(1+eta)*(1-zeta)...
        (1-xi)*(1-eta)*(1+zeta) (1+xi)*(1-eta)*(1+zeta) (1+xi)*(1+eta)*(1+zeta) (1-xi)*(1+eta)*(1+zeta)];

Bex=1/8*[-(1-eta)*(1-zeta) (1-eta)*(1-zeta) (1+eta)*(1-zeta) -(1+eta)*(1-zeta)...
        -(1-eta)*(1+zeta) (1-eta)*(1+zeta) (1+eta)*(1+zeta) -(1+eta)*(1+zeta);
        -(1-xi)*(1-zeta) -(1+xi)*(1-zeta) (1+xi)*(1-zeta) (1-xi)*(1-zeta)...
        -(1-xi)*(1+zeta) -(1+xi)*(1+zeta) (1+xi)*(1+zeta) (1-xi)*(1+zeta);
        -(1-xi)*(1-eta) -(1+xi)*(1-eta) -(1+xi)*(1+eta) -(1-xi)*(1+eta)...
        (1-xi)*(1-eta) (1+xi)*(1-eta) (1+xi)*(1+eta) (1-xi)*(1+eta)];
end





