clc;
clear;

load('DATOS_prac3.mat');
load('dades.mat');

neig=25; %modes
nnode=size(COOR,1);
ndim=size(COOR,2);
lnod=1:nnode*ndim;
lnod(DOFr)=[];

M=M(lnod,lnod);
K=K(lnod,lnod);

[mode,freq]=UndampedFREQ(M,K,neig);
xi=0.01;
m=40;
time=linspace(0,m*2*pi/freq(5),500);

%% Amplitude VS time
figure
q0=zeros(1,neig);
for i=1:neig
    q0(i)=abs(mode(:,i)'*M*d(lnod));
end
bar(q0);
xlabel('Modes'), ylabel('Amplitude'), title('Modes - Amplitude')

%% Freq VS amplitude
figure
q0=zeros(1,neig);
x=strings(1,neig);

for i=1:neig
    q0(i)=abs(mode(:,i)'*M*d(lnod));
    x{i}=num2str(round(freq(i)));
end
bar(q0);
xticks(1:length(q0))
xticklabels(x(1:end))
xlabel('\omega [rad/s]'), ylabel('Amplitude'), title('Modes - Amplitude')

figure
for i=1:neig
    q0(i)=abs(mode(:,i)'*M*d(lnod));
    x{i}=num2str(round(freq(i)/(2*pi)));
end
bar(q0);
xticks(1:length(q0))
xticklabels(x(1:end))

xlabel('Frequency [Hz]'), ylabel('Amplitude'), title('Modes - Amplitude')

GidPostProcessModes(COOR,CN,TypeElement,mode,posgp',NameFileMesh,DATA,lnod);

%% 
DISP=zeros(length(lnod),500);
for j=1:length(time)
    t=time(j);
    for i=1:neig
        DISP(:,j)=DISP(:,j)+mode(:,i)*(exp(-xi*freq(i)*t)*(q0(i)*cos(freq(i)*t)...
            +(xi*freq(i)*q0(i))/(freq(i))*sin(freq(i)*t)));
    end
end
DISP1=zeros(nnode*3,500);
for i=1:length(time)
    DISP1(lnod,i)=DISP(:,i);
end
GidPostProcessDynamic(COOR,CN,TypeElement,DISP1, NAME_INPUT_DATA,posgp',NameFileMesh,time')

%%
L=2;
rho = 2700;
E = 70e9; 
e=0.05;
y=0.25;
%h=0.25;

Area=y^2-(y-2*e)^2;
I=(1/12)*(y^4-(y-2*e)^4);

m1=1.875;
f1=(m1^2)/(2*pi*L^2)*(sqrt((E*I)/(rho*Area)));
w1=f1*2*pi;


