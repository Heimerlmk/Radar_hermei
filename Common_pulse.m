%%�����״﷢�䲨��
%%ƽ̨��R2016a
clear all;close all;clc;

%% ��������
fft_Num = 4096;
fs = 1000;      %������
t  = (0:fft_Num-1)/fs;
f0 = 1; 
f = fs/fft_Num * (0:fft_Num - 1);

%% ������
st_1 = sin(2*pi*f0.*t);
figure(1);
subplot(2,1,1);plot(st_1);
title('������');
subplot(2,1,2);plot(f,abs(fft(st_1,fft_Num)));


%% ���Ե�Ƶ�ź�
K = 1;
ft_2 = K.*t;
st_2 = sin( 2*pi*f0.*t + 2*pi.*ft_2 .* t);
figure(2);
subplot(2,1,1);plot(st_2);
title('���Ե�Ƶ');
subplot(2,1,2);plot(f,abs(fft(st_2,fft_Num)));

%% �����Ե�Ƶ�ź�
ft_3 = t.^2;
st_3 = sin( 2*pi*f0.*t + 2*pi.*ft_3 .* t);
figure(3);
%hold on
subplot(2,1,1);plot(st_3);
title('�����Ե�Ƶ');
subplot(2,1,2);plot(f,abs(fft(st_3,fft_Num))); %�����ln��t���������st_3��fft����ְ���

%% ��λ���룬��λ�Ϳ���
code=[1,1,1,0,0,1,0];
t_tao = (0:500-1)/fs;  %�ʼ�����������4096��7�ı������õ�,ֻ����3500����Ķ������
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
plot(t,st_4),xlabel('t(��λ����)');title('�����루��λ�Ϳ��룩');
subplot(2,1,2);
subplot(2,1,2);plot(f,abs(fft(st_4,fft_Num)));

%% �����ȵ����ˣ����ڻ��һЩ������������ͬ�ĵ�Ƶ�źŶ��״����ܵ�Ӱ�졣
