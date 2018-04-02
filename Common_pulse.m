%%常用雷达发射波形
%%平台：R2016a
clear all;close all;clc;

%% 参数设置
fft_Num = 4096;
fs = 1000;      %采样率
t  = (0:fft_Num-1)/fs;
f0 = 1; 
f = fs/fft_Num * (0:fft_Num - 1);

%% 简单脉冲
st_1 = sin(2*pi*f0.*t);
figure(1);
subplot(2,1,1);plot(st_1);
title('简单脉冲');
subplot(2,1,2);plot(f,abs(fft(st_1,fft_Num)));


%% 线性调频信号
K = 1;
ft_2 = K.*t;
st_2 = sin( 2*pi*f0.*t + 2*pi.*ft_2 .* t);
figure(2);
subplot(2,1,1);plot(st_2);
title('线性调频');
subplot(2,1,2);plot(f,abs(fft(st_2,fft_Num)));

%% 非线性调频信号
ft_3 = t.^2;
st_3 = sin( 2*pi*f0.*t + 2*pi.*ft_3 .* t);
figure(3);
%hold on
subplot(2,1,1);plot(st_3);
title('非线性调频');
subplot(2,1,2);plot(f,abs(fft(st_3,fft_Num))); %如果是ln（t），这里的st_3的fft很奇怪啊。

%% 相位编码，七位巴克码
code=[1,1,1,0,0,1,0];
t_tao = (0:500-1)/fs;  %最开始采样点设的是4096，7的倍数不好调,只能做3500个点的二相编码
n = length(code);
st_4 = zeros(1,length(t));
for i=1:n
    if code(i)==1
        pha=1;
    else    pha=0;
    end
    st_4(1,(i-1)*length(t_tao)+1:i*length(t_tao))=sin(2*pi*f0*t_tao+pha*pi);
end
figure(4);
subplot(2,1,1);
plot(t,st_4),xlabel('t(单位：秒)');title('二相码（七位巴克码）');
subplot(2,1,2);
subplot(2,1,2);plot(f,abs(fft(st_4,fft_Num)));

%% 编码先到这了，后期会加一些分析，分析不同的调频信号对雷达性能的影响。
