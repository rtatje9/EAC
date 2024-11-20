function [weig, posgp, shapef, dershapef] = Quadrilateral4NInPoints()
 
 ndimensions = 2;
 nnodeE = 2^ndimensions;
 weig = ones(1, nnodeE);
 ngauss = length(weig);

 signsMatrix = [ -1  1  1 -1;  % signs of xi
                 -1 -1  1  1]; % signs of eta

 posgp = (1/sqrt(3)) * signsMatrix;

 shapef = zeros(ngauss, nnodeE);
 dershapef = zeros(ndimensions, nnodeE, ngauss);

 for gaussIdx = 1:ngauss
     xiVal = posgp(1, gaussIdx);
     etaVal = posgp(2, gaussIdx);

     shapef(gaussIdx, :) = (1 / nnodeE) * [
         (1 - xiVal) * (1 - etaVal), 
         (1 + xiVal) * (1 - etaVal), 
         (1 + xiVal) * (1 + etaVal), 
         (1 - xiVal) * (1 + etaVal)
     ];

     dershapef(:, :, gaussIdx) = (1 / nnodeE) * signsMatrix .* [
         (1 - etaVal), (1 - etaVal), (1 + etaVal), (1 + etaVal);
         (1 - xiVal),  (1 + xiVal),  (1 + xiVal),  (1 - xiVal)
     ];
 end

end



 