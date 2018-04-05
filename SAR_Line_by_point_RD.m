%%Filename: SAR���񡪡���Ŀ��
%%��ִ��Line_set�趨�߶β�����֮����ִ�б��ļ���
%%windows 10, R2016a

% clear;clc;close all;
%% ��������
C = 3e8;        %����
fc = 1e9;       %��Ƶ1GHz
lambda = C/fc;  %����

% Ŀ�������
Xmin=0;                         
Xmax=50;                  
Yc=10000;                      
Y0=500; 

% SAR����
V=100;                           %SARƽ̨�ƶ��ٶ�
H=5000;                          %����߶�
R0=sqrt(Yc^2+H^2);               %б��

D=4;                             %���ߵ�Ч�׾� 4m
Lsar=lambda*R0/D;                %�ϳɿ׾�����
Tsar=Lsar/V;                     %�ϳ�ʱ��
                                 
%��ʱ�����                       
Ka=-2*V^2/lambda/R0;             %�ز���Ƶб��
Ba=abs(Ka*Tsar);                 %�ز���Ƶ����
PRF=Ba;                          %�����ظ�Ƶ��
PRT=1/PRF;                       %�����ظ�ʱ��
ds=PRT;                          %����ʱ����
                                 
Nslow=ceil((Xmax-Xmin+Lsar)/V/ds); %�ز�����
Nslow=2^nextpow2(Nslow);           %���ջز�������2�Ĵ���
sn=(linspace((Xmin-Lsar/2)/V,(Xmax+Lsar/2)/V,Nslow));%����ʱ�����

%���ݵ�����������
PRT=(Xmax-Xmin+Lsar)/V/Nslow;    
PRF=1/PRT;
ds=PRT;

%�����������
Tr=5e-6;                        %���� 10us
Br=30e6;                        %chirp�źŴ��� 30MHz
Kr=Br/Tr;                       %chirp ��Ƶ
Fsr=3*Br;                       %ȡ����Ƶ��Ϊ3������
dt=1/Fsr;                       %�������
Rmin=sqrt((Yc-Y0)^2+H^2);
%Rmax=sqrt((Yc+Y0)^2+H^2+(Lsar/2)^2);
Rmax=sqrt((Yc+Y0)^2+H^2);

Nfast=ceil(2*(Rmax-Rmin)/C/dt+Tr/dt);%�������������
Nfast=2^nextpow2(Nfast);             %2����
tm=(linspace(2*Rmin/C,2*Rmax/C+Tr,Nfast)); %�����򲽽�ʱ����
%���ݵ�����������
dt=(2*Rmax/C+Tr-2*Rmin/C)/Nfast;    
Fsr=1/dt;

%�ֱ���
DY=C/2/Br;                           %����ֱ���
DX=D/2;                              %��λ��ֱ���

%%Parameter--point targets
 Ntarget=point_Num;                          %Ŀ�������
 %format [x, y, reflectivity]
%  Ptarget=[Xmin,Yc,1                  %Ŀ�����Ϣ
%           Xmin,Yc+1*DY,1
%           Xmin,Yc+2*DY,1
%           Xmin,Yc+3*DY,1
%           Xmin,Yc+4*DY,1
%           Xmin,Yc+5*DY,1
%           Xmin,Yc+6*DY,1
%           Xmin,Yc+7*DY,1
%           Xmin,Yc+8*DY,1
%           Xmin,Yc+9*DY,1
% %          Xmin+20*DX,Yc+50*DY,1
%           ];  
disp('����:')
disp('�������������');disp(Fsr/Br)
disp('�������������');disp(Nfast)
disp('��λ���������');disp(PRF/Ba)
disp('��λ������ز�');disp(Nslow)
disp('����ֱ���');disp(DY)
disp('��λ��ֱ���');disp(DX)     
disp('SAR�ϳɿ׾�����');disp(Lsar)     
disp('��Ŀ�����');disp(Ptarget)

%%����ԭʼ�ز��ź�����
K=Ntarget;                                %����
N=Nslow;                                  %�ز�����
M=Nfast;                                  %�����������
T=Ptarget;                                %��λ�ô���
Srnm=(zeros(N,M));
for k=1:1:K
    sigma=T(k,3);
    Dslow=sn*V-T(k,1);
    R=sqrt(Dslow.^2+T(k,2)^2+H^2);        % б�ࣺx,y,z
    tau=2*R/C;
    Dfast=ones(N,1)*tm-tau'*ones(1,M);    %����NxM��ʱ�Ӿ��󣬲��Ե��ۼ�
    phase=pi*Kr*Dfast.^2-(4*pi/lambda)*(R'*ones(1,M));
    Srnm=Srnm+sigma*exp(1j*phase).*(0<Dfast&Dfast<Tr).*((abs(Dslow)<Lsar/2)'*ones(1,M));
end

%% ����ѹ��
tr=tm-2*Rmin/C;
Refr=exp(1j*pi*Kr*tr.^2).*rectpuls(tr-Tr/2,Tr);%(0<tr&tr<Tr); %�ο��źţ�rectpuls(t-Tp/2,Tp)
Sr=ifty(fty(Srnm).*(ones(N,1)*conj(fty(Refr))));
Gr=abs(Sr);

%% ��λ��ѹ��
ta=sn-Xmin/V;
Refa=exp(1j*pi*Ka*ta.^2).*(abs(ta)<Tsar/2);         %��λ��ο��ź�
Sa=iftx(ftx(Sr).*(conj(ftx(Refa)).'*ones(1,M)));
Ga=abs(Sa);

figure(1)
subplot(211);
row=tm*C/2-2008;col=sn*V-26;
imagesc(row,col,Gr);           
%axis([Yc-Y0,Yc+Y0,Xmin-Lsar/2,Xmax+Lsar/2]);
xlabel('��������루m��');ylabel('��λ�����');title('����ѹ�������');
subplot(212);
imagesc(row,col,Ga);          
%axis([Yc-Y0,Yc+Y0,Xmin-Lsar/2,Xmax+Lsar/2]);
xlabel('��������루m��');ylabel('��λ�����');title('����ͷ�λ��ѹ�������');

%% 
figure(2)
waterfall(real(Srnm((200:205),:)));axis tight
%mesh(row,col,real(Srnm));
xlabel('����'),ylabel('��λ'),
title('�ز��ź�ʵ��'),
figure(3)
waterfall(Gr);axis tight
xlabel('����'),ylabel('��λ'),
title('����SAR����ѹ��֮��'),
 figure(4)
 mesh(abs(Ga));axis tight
 xlabel('����'),ylabel('��λ'),
 title('����SAR RD ֮��'),
 
%�����������⣬Ӧ�������޸ģ����������Էֱ���Ϊ��Ԫ�ĳ�����û�������
%�Էֱ��ʵ�Ԫ��һ�����û������