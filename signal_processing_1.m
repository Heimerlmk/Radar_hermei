%%雷达信号基本处理流程 脉压
%%平台：R2016a

clear all;close all;clc;

%% 基本参数设置
f0 = 10e9;       %载频
Tp = 10e-6;      %脉冲宽度
B  = 10e6;       %信号带宽
fs = 100e6;      %采样率
R0 = 3000;       %目标初始距离
c  = 3e8;        %光速
tr = 2*R0/c;     %目标点延时
k  = B/Tp;       %调频斜率
N  = 4096;       %采样点数
t  = (0:N-1)/fs; %采样时间步进

%% 发射信号
S0 = rectpuls(t-Tp/2,Tp) .* exp(1i*pi*k*(t-Tp/2).^2);
figure(1);
subplot(2,1,1);plot(t*c/2,real(S0));title('发射信号实部');xlabel('距离/m');
subplot(2,1,2);plot(t*c/2,imag(S0));title('发射信号虚部');xlabel('距离/m');
%subplot(3,1,3);plot(abs(fft(S0)));

%% 发射信号频谱
S0_fft = fft(S0,N);

%% 回波构造
S1 = rectpuls(t-tr-Tp/2,Tp) .* exp(1i*pi*k*(t-tr-Tp/2).^2) .* exp(-1i*2*pi*f0*tr);
figure(2);
subplot(2,1,1);plot(t*c/2,real(S1));title('回波函数实部');xlabel('距离/m');
subplot(2,1,2);plot(t*c/2,imag(S1));title('回波函数虚部');xlabel('距离/m');
%subplot(3,1,3);plot(abs(fft(S1)));

%% 回波频谱
f = fs/N * (-N/2:N/2 - 1);
S1_fft = fft(S1,N);
figure(3);
subplot(2,1,1);plot(abs(S1_fft));title('回波频谱');xlabel('频率');
subplot(2,1,2);plot(fftshift(abs(S1_fft)));title('回波频谱');xlabel('频率');

%% 脉冲压缩
S_F = ifft( S1_fft .* conj(S0_fft));
figure(4);
subplot(2,1,1);plot(t*c/2,abs(S_F));title('脉压');xlabel('距离/m');
subplot(2,1,2);plot(t*c/2,db(abs(S_F)/max(S_F)));title('归一化');xlabel('距离/m');

%% 频域加窗
win = hamming(410);
window = [zeros(1,1843),win',zeros(1,1843)];  %窗矩阵

S0_fft_w = fftshift(S0_fft);
S0_fft_w = window .* S0_fft_w;
% figure(5)
% plot(f,S0_fft_w);title('频谱加窗');xlabel('频率/Hz');

%% 加窗后脉压
S_F_w = ifft( S1_fft .* conj(fftshift(S0_fft_w)));
figure(6);
%subplot(2,1,1);plot(t*c/2,abs(S_F_w));title('脉压');xlabel('距离/m');
%subplot(2,1,2);
plot(t*c/2,db(abs(S_F_w)/max(S_F_w)));title('频域加窗后脉压');xlabel('距离/m');ylabel('dB');
% S_F_w = window .* S_F;
% figure(5);
% %hold on
% subplot(2,1,1);plot(c*t/2,abs(S_F_w));title('加窗');xlabel('距离/m');
% subplot(2,1,2);plot(t*c/2,db(abs(S_F_w)/max(S_F_w)));title('归一化');xlabel('距离/m');

%% 加窗和未加窗对比
% figure(6)
% plot(t*c/2,abs(S_F));
% hold on;
% plot(c*t/2,abs(S_F_w),'r');xlabel('距离/m');title('脉压');
% figure(7)
% plot(t*c/2,db(abs(S_F)/max(S_F)));
% hold on;
% plot(t*c/2,db(abs(S_F_w)/max(S_F_w)),'r');title('归一化');xlabel('距离/m');

figure(7)
plot(t*c/2,db(abs(S_F)/max(S_F)));
hold on
plot(t*c/2,db(abs(S_F_w)/max(S_F_w)),'r');title('频域加窗和未加窗对比');xlabel('距离/m');ylabel('dB');

%% 时域加窗
S0_w = hamming(1000)' .* S0(1:1000);
S_F_wt = ifft(S1_fft.*conj(fft(S0_w,N)));
figure(8)
plot(t*c/2,db(abs(S_F_wt)/max(S_F_wt)));
hold on
plot(t*c/2,db(abs(S_F_w)/max(S_F_w)),'r');title('时域和频域加窗对比');xlabel('距离/m');ylabel('dB');
legend('时域','频域');


% figure(8)
% plot(t*c/2,db(abs(S_F)/max(S_F)).*window);