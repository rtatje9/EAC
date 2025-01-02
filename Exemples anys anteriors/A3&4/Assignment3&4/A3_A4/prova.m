clc
clear

%% MODAL DECOMPOSITION ANALYSIS

%DATA LOADING
load('DATOS_prac3.mat');
load('dades.mat');

%NUMBER OF MODES
neig=25;

%NODAL PARAMETERS
nnode = size(COOR,1); ndim = size(COOR,2);
lnod = 1:nnode*ndim; 
lnod(DOFr) = [];



%MATRICES CHOPPING
M=M(lnod,lnod);                             % Mass matrix of the free DOF
K=K(lnod,lnod);                             % Stiffness matrix of the free DOF


%EQUATION DEFINITIONS
[MODES, FREQ] = UndampedFREQ(M,K,neig);     % Modes and angular velocity
xi=0.01; % Damping
m = 40;
time=linspace(0,m*2*pi/FREQ(5),500);       % Time discretization

figure %MODES
%INITIAL CONDITIONS
q0 = zeros(1, neig);

for i=1:neig
    q0(i)=abs(MODES(:,i)'*M*d(lnod));       % Amplitude
       
end
bar(q0);
xlabel('Modes'),ylabel('Amplitude'),title('Modes vs amplitude');




figure %FREQUENCIES
%INITIAL CONDITIONS
q0 = zeros(1, neig);
label_x = strings(1,neig);

for i=1:neig
    q0(i)=abs(MODES(:,i)'*M*d(lnod));       % Amplitude
    label_x{i}=num2str(round(FREQ(i)));     
end
bar(q0);

xticks([1: length(q0)])
xticklabels(label_x(1:end))

xlabel('\omega [rad/s]'),ylabel('Amplitude'),title('Modes vs amplitude');

figure
for i=1:neig
    q0(i)=abs(MODES(:,i)'*M*d(lnod));       % Amplitude
    label_x{i}=num2str(round(FREQ(i)/(2*pi)));     
end
bar(q0);

xticks([1: length(q0)])
xticklabels(label_x(1:end))

xlabel('f [Hz]'),ylabel('Amplitude'),title('Modes vs amplitude');






GidPostProcessModes(COOR,CN,TypeElement,MODES,posgp',NameFileMesh,DATA,lnod);