%%Filename: SAR成像——线目标
%%先执行Line_set设定线段参数，之后再执行本文件。
%%windows 10, R2016a

% clear;clc;close all;
%% 参数设置
C = 3e8;        %光速
fc = 1e9;       %载频1GHz
lambda = C/fc;  %波长

% 目标点区域
Xmin=0;                         
Xmax=50;                  
Yc=10000;                      
Y0=500; 

% SAR参数
V=100;                           %SAR平台移动速度
H=5000;                          %轨道高度
R0=sqrt(Yc^2+H^2);               %斜距

D=4;                             %天线等效孔径 4m
Lsar=lambda*R0/D;                %合成孔径长度
Tsar=Lsar/V;                     %合成时间
                                 
%慢时间参数                       
Ka=-2*V^2/lambda/R0;             %回波调频斜率
Ba=abs(Ka*Tsar);                 %回波调频带宽
PRF=Ba;                          %脉冲重复频率
PRT=1/PRF;                       %脉冲重复时间
ds=PRT;                          %步进时间间隔
                                 
Nslow=ceil((Xmax-Xmin+Lsar)/V/ds); %回波数量
Nslow=2^nextpow2(Nslow);           %最终回波数量，2的次幂
sn=(linspace((Xmin-Lsar/2)/V,(Xmax+Lsar/2)/V,Nslow));%步进时间矩阵

%根据点数更新数据
PRT=(Xmax-Xmin+Lsar)/V/Nslow;    
PRF=1/PRT;
ds=PRT;

%脉冲参数设置
Tr=5e-6;                        %脉宽 10us
Br=30e6;                        %chirp信号带宽 30MHz
Kr=Br/Tr;                       %chirp 调频
Fsr=3*Br;                       %取采样频率为3倍带宽
dt=1/Fsr;                       %样本间距
Rmin=sqrt((Yc-Y0)^2+H^2);
%Rmax=sqrt((Yc+Y0)^2+H^2+(Lsar/2)^2);
Rmax=sqrt((Yc+Y0)^2+H^2);

Nfast=ceil(2*(Rmax-Rmin)/C/dt+Tr/dt);%距离向采样点数
Nfast=2^nextpow2(Nfast);             %2次幂
tm=(linspace(2*Rmin/C,2*Rmax/C+Tr,Nfast)); %距离向步进时间间隔
%根据点数更新数据
dt=(2*Rmax/C+Tr-2*Rmin/C)/Nfast;    
Fsr=1/dt;

%分辨率
DY=C/2/Br;                           %距离分辨率
DX=D/2;                              %方位向分辨率

%%Parameter--point targets
 Ntarget=point_Num;                          %目标点数量
 %format [x, y, reflectivity]
%  Ptarget=[Xmin,Yc,1                  %目标点信息
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
disp('参数:')
disp('距离向采样倍率');disp(Fsr/Br)
disp('距离向采样点数');disp(Nfast)
disp('方位向采样倍率');disp(PRF/Ba)
disp('方位向采样回波');disp(Nslow)
disp('距离分辨率');disp(DY)
disp('方位向分辨率');disp(DX)     
disp('SAR合成孔径长度');disp(Lsar)     
disp('点目标参数');disp(Ptarget)

%%生成原始回波信号数据
K=Ntarget;                                %点数
N=Nslow;                                  %回波数量
M=Nfast;                                  %距离向采样点
T=Ptarget;                                %点位置带入
Srnm=(zeros(N,M));
for k=1:1:K
    sigma=T(k,3);
    Dslow=sn*V-T(k,1);
    R=sqrt(Dslow.^2+T(k,2)^2+H^2);        % 斜距：x,y,z
    tau=2*R/C;
    Dfast=ones(N,1)*tm-tau'*ones(1,M);    %构成NxM的时延矩阵，并对点累加
    phase=pi*Kr*Dfast.^2-(4*pi/lambda)*(R'*ones(1,M));
    Srnm=Srnm+sigma*exp(1j*phase).*(0<Dfast&Dfast<Tr).*((abs(Dslow)<Lsar/2)'*ones(1,M));
end

%% 距离压缩
tr=tm-2*Rmin/C;
Refr=exp(1j*pi*Kr*tr.^2).*rectpuls(tr-Tr/2,Tr);%(0<tr&tr<Tr); %参考信号；rectpuls(t-Tp/2,Tp)
Sr=ifty(fty(Srnm).*(ones(N,1)*conj(fty(Refr))));
Gr=abs(Sr);

%% 方位向压缩
ta=sn-Xmin/V;
Refa=exp(1j*pi*Ka*ta.^2).*(abs(ta)<Tsar/2);         %方位向参考信号
Sa=iftx(ftx(Sr).*(conj(ftx(Refa)).'*ones(1,M)));
Ga=abs(Sa);

figure(1)
subplot(211);
row=tm*C/2-2008;col=sn*V-26;
imagesc(row,col,Gr);           
%axis([Yc-Y0,Yc+Y0,Xmin-Lsar/2,Xmax+Lsar/2]);
xlabel('距离向距离（m）');ylabel('方位向距离');title('距离压缩后成像');
subplot(212);
imagesc(row,col,Ga);          
%axis([Yc-Y0,Yc+Y0,Xmin-Lsar/2,Xmax+Lsar/2]);
xlabel('距离向距离（m）');ylabel('方位向距离');title('距离和方位向压缩后成像');

%% 
figure(2)
waterfall(real(Srnm((200:205),:)));axis tight
%mesh(row,col,real(Srnm));
xlabel('距离'),ylabel('方位'),
title('回波信号实部'),
figure(3)
waterfall(Gr);axis tight
xlabel('距离'),ylabel('方位'),
title('条带SAR距离压缩之后'),
 figure(4)
 mesh(abs(Ga));axis tight
 xlabel('距离'),ylabel('方位'),
 title('条带SAR RD 之后'),
 
%成像区间问题，应该做出修改，但大体上以分辨率为单元的成像是没有问题的
%以分辨率单元的一半成像没有问题