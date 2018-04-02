%%雷达信号基本处理流程 PD
%%平台：R2016a

clear all;close all;clc;

%% 基本参数设置
f0 = 10e9;       %载频
Tp = 10e-6;      %脉冲宽度
B  = 10e6;       %信号带宽
fs = 100e6;      %采样率
R0 = 3000;       %目标初始距离
c  = 3e8;        %光速
tr = 2*R0/c;     %延时
k  = B/Tp;       %调频斜率
N  = 4096;       %采样个数
t  = (0:N-1)/fs; %采样步进
CPI = 512;        %脉冲个数   %在这里分别实验的采样回波个数，64、128、256、512，发现当回波数量增多时，速度会接近给定值。 
Tr = 100e-6;     %脉冲重复周期
v  = 60;         %朝向雷达速度
lambda = c/f0;   %波长


h = waitbar(0,'计算中……');
%% 回波构造
S = zeros(CPI,N);
for n=1:CPI
    tau_m = 2*(R0-n*Tr*v)/c;
    S(n,:) = rectpuls(t-tau_m-Tp/2,Tp) .* exp(1i*pi*k*(t-tau_m-Tp/2).^2) .* exp(-1i*2*pi*f0*tau_m);
end

%% 回波频谱
fft_Num = N;
f = (0:fft_Num-1) / fft_Num * fs;
for n = 1:CPI
    Spetrum(n,:) = fft( S(n,:),fft_Num);
end

%% 参考信号
Sr = rectpuls(t-Tp/2,Tp) .* exp(1i*pi*k*(t-Tp/2).^2);
Sr_fft = fft(Sr,fft_Num);

%% 距离向脉压
Scomp = zeros(CPI,N);
for n=1:CPI
    Scomp(n,:) = ifft(Spetrum(n,:) .* conj(Sr_fft));
end

figure(1);
imagesc(t*c/2,1:CPI,abs(Scomp));
figure(2);
plot(t*c/2,abs(Scomp(3,:))); title('距离向脉压')
figure(3)
mesh(t*c/2,1:CPI,abs(Scomp));

%% PD处理
PD = Scomp;
for n = 1 : N
    PD(:,n) = fftshift(fft(Scomp(:,n)));
end

%L = 1:CPI;
L = t*c/2;
m = -(CPI/2):CPI/2 - 1;
delta_f = m.*(1/Tr/CPI);
V = delta_f * lambda /2;
figure(4);
imagesc(L,V,abs(PD));xlabel('距离(m)');ylabel('速度(m/s)');title('脉冲多普勒处理');

figure(4);  
mesh(L,V,abs(PD));

close(h); % 注意必须添加close函数

[row,col] = find( abs(PD) == max(max(abs(PD))));

V_point = V(row)   %速度有误差，why？速度分辨力应该怎么算
R_point = L(col)  




