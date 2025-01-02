load("INFO_FE.mat") %info about COOR, DOFr and React

cg=[0 0.125 -0.125]; 
Re=React(DOFr); %save reaction values of each DOFr
R_total=reshape(Re,[length(DOFr)/3,3]); 
fixed_nod_dim=size(R_total,1);
fixed_COOR=zeros(fixed_nod_dim,3);
fixed_nod=DOFr(end-fixed_nod_dim+1:end,:);
fixed_COOR(:,:)=COOR(fixed_nod/3,:); 

Suma_total=sum(R_total,1);

Rx=Suma_total(1);
Ry=Suma_total(2);
Rz=Suma_total(3);
d=zeros(fixed_nod_dim,3);
for i=1:size(R_total,1)
    d(i,:)=[(fixed_COOR(i,1)-cg(1,1)) (fixed_COOR(i,2)-cg(1,2)) (fixed_COOR(i,3)-cg(1,3))];
end
M=cross(d,R_total); %perpendicular vector d x R_total
SumaM=sum(M,1);
Mx=SumaM(1);
My=SumaM(2);
Mz=SumaM(3);