%%�״��źŻ����������� ��ѹ
%%ƽ̨��R2016a

clear all;close all;clc;

%% ������������
f0 = 10e9;       %��Ƶ
Tp = 10e-6;      %������
B  = 10e6;       %�źŴ���
fs = 100e6;      %������
R0 = 3000;       %Ŀ���ʼ����
c  = 3e8;        %����
tr = 2*R0/c;     %Ŀ�����ʱ
k  = B/Tp;       %��Ƶб��
N  = 4096;       %��������
t  = (0:N-1)/fs; %����ʱ�䲽��

%% �����ź�
S0 = rectpuls(t-Tp/2,Tp) .* exp(1i*pi*k*(t-Tp/2).^2);
figure(1);
subplot(2,1,1);plot(t*c/2,real(S0));title('�����ź�ʵ��');xlabel('����/m');
subplot(2,1,2);plot(t*c/2,imag(S0));title('�����ź��鲿');xlabel('����/m');
%subplot(3,1,3);plot(abs(fft(S0)));

%% �����ź�Ƶ��
S0_fft = fft(S0,N);

%% �ز�����
S1 = rectpuls(t-tr-Tp/2,Tp) .* exp(1i*pi*k*(t-tr-Tp/2).^2) .* exp(-1i*2*pi*f0*tr);
figure(2);
subplot(2,1,1);plot(t*c/2,real(S1));title('�ز�����ʵ��');xlabel('����/m');
subplot(2,1,2);plot(t*c/2,imag(S1));title('�ز������鲿');xlabel('����/m');
%subplot(3,1,3);plot(abs(fft(S1)));

%% �ز�Ƶ��
f = fs/N * (-N/2:N/2 - 1);
S1_fft = fft(S1,N);
figure(3);
subplot(2,1,1);plot(abs(S1_fft));title('�ز�Ƶ��');xlabel('Ƶ��');
subplot(2,1,2);plot(fftshift(abs(S1_fft)));title('�ز�Ƶ��');xlabel('Ƶ��');

%% ����ѹ��
S_F = ifft( S1_fft .* conj(S0_fft));
figure(4);
subplot(2,1,1);plot(t*c/2,abs(S_F));title('��ѹ');xlabel('����/m');
subplot(2,1,2);plot(t*c/2,db(abs(S_F)/max(S_F)));title('��һ��');xlabel('����/m');

%% Ƶ��Ӵ�
win = hamming(410);
window = [zeros(1,1843),win',zeros(1,1843)];  %������

S0_fft_w = fftshift(S0_fft);
S0_fft_w = window .* S0_fft_w;
% figure(5)
% plot(f,S0_fft_w);title('Ƶ�׼Ӵ�');xlabel('Ƶ��/Hz');

%% �Ӵ�����ѹ
S_F_w = ifft( S1_fft .* conj(fftshift(S0_fft_w)));
figure(6);
%subplot(2,1,1);plot(t*c/2,abs(S_F_w));title('��ѹ');xlabel('����/m');
%subplot(2,1,2);
plot(t*c/2,db(abs(S_F_w)/max(S_F_w)));title('Ƶ��Ӵ�����ѹ');xlabel('����/m');ylabel('dB');
% S_F_w = window .* S_F;
% figure(5);
% %hold on
% subplot(2,1,1);plot(c*t/2,abs(S_F_w));title('�Ӵ�');xlabel('����/m');
% subplot(2,1,2);plot(t*c/2,db(abs(S_F_w)/max(S_F_w)));title('��һ��');xlabel('����/m');

%% �Ӵ���δ�Ӵ��Ա�
% figure(6)
% plot(t*c/2,abs(S_F));
% hold on;
% plot(c*t/2,abs(S_F_w),'r');xlabel('����/m');title('��ѹ');
% figure(7)
% plot(t*c/2,db(abs(S_F)/max(S_F)));
% hold on;
% plot(t*c/2,db(abs(S_F_w)/max(S_F_w)),'r');title('��һ��');xlabel('����/m');

figure(7)
plot(t*c/2,db(abs(S_F)/max(S_F)));
hold on
plot(t*c/2,db(abs(S_F_w)/max(S_F_w)),'r');title('Ƶ��Ӵ���δ�Ӵ��Ա�');xlabel('����/m');ylabel('dB');

%% ʱ��Ӵ�
S0_w = hamming(1000)' .* S0(1:1000);
S_F_wt = ifft(S1_fft.*conj(fft(S0_w,N)));
figure(8)
plot(t*c/2,db(abs(S_F_wt)/max(S_F_wt)));
hold on
plot(t*c/2,db(abs(S_F_w)/max(S_F_w)),'r');title('ʱ���Ƶ��Ӵ��Ա�');xlabel('����/m');ylabel('dB');
legend('ʱ��','Ƶ��');


% figure(8)
% plot(t*c/2,db(abs(S_F)/max(S_F)).*window);