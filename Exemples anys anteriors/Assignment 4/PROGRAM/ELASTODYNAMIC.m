%ELASTODYNAMIC

clc;
clear;

%Upload the data
load('Data_Assignment4.mat');
load('Matrius_K_M.mat');

%Parameters
n_modes = 25; 
n_node=size(COOR,1);
n_dim=size(COOR,2);

