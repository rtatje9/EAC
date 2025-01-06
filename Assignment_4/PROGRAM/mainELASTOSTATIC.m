clc
clear all
% Finite Element Program for Elastostatic problems  
% ECA.
% Technical University of Catalonia
% JoaquIn A. Hdez, October 23-th, 2015
% ---------------------------------------------------
if exist('ElemBnd')==0
    addpath('ROUTINES_AUX') ,
end

 
%%% INPUT  %%% 
% Input data file %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

NAME_INPUT_DATA = 'BEAM3D_ASSIGN_TORQUE' ;  % Name of the mesh file 
%------------------------------------------------------

% PREPROCESS  
[COOR,CN,TypeElement,TypeElementB, densglo, celasglo,  DOFr,dR,...  
    Tnod,CNb,fNOD,Fpnt,NameFileMesh,typePROBLEM,celasgloINV,DATA] = ReadInputDataFile(NAME_INPUT_DATA)  ; 

% SOLVER 
% --------------------------------------------
[d strainGLO stressGLO  React posgp]= SolveElastFE(COOR,CN,TypeElement,TypeElementB, densglo, celasglo,  DOFr,dR,...  
    Tnod,CNb,fNOD,Fpnt,typePROBLEM,celasgloINV,DATA)  ; 

save('DATA_prac3.mat');


% POSTPROCESS
% --------------------------------------------
GidPostProcess(COOR,CN,TypeElement,d,strainGLO, stressGLO,  React,NAME_INPUT_DATA,posgp,NameFileMesh,DATA);