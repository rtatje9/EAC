% Code to compute reactions forces

load("Reactions_info.mat") %upload the information about React, COOR and DOFr

cdg = [0 0.125 -0.125];
Reactions_DOFr = React(DOFr); % saving reactions of each DOFr
Reactions_Total = reshape(Reactions_DOFr, [length(DOFr)/3,3]);
fnod_dim = size(Reactions_Total,1);
fnod=DOFr(end-fnod_dim+1:end, :);
fCOOR = zeros(fnod_dim,3);
fCOOR(:,:) = COOR(fnod/3, :);

TotalR = sum(Reactions_Total,1);

% Calculate each reaction at the fixed end:

Rx = TotalR(1);
Ry = TotalR(2);
Rz = TotalR(3);

% Momentums

dist = zeros(fnod_dim,3);
%Calculate distance (lever arm)
for i=1:size(Reactions_Total,1)
    dist(i,:)=[(fCOOR(i,1)-cdg(1,1)) (fCOOR(i,2)-cdg(1,2)) (fCOOR(i,3)-cdg(1,3))];
end

Momentum = cross(dist,Reactions_Total); % to compute vectorial product
TotalM= sum(Momentum,1);

% Calculate each momentum:

Mx = TotalM(1);
My = TotalM(2);
Mz = TotalM(3);