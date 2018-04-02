%%�״��źŻ����������� PD
%%ƽ̨��R2016a

clear all;close all;clc;

%% ������������
f0 = 10e9;       %��Ƶ
Tp = 10e-6;      %������
B  = 10e6;       %�źŴ���
fs = 100e6;      %������
R0 = 3000;       %Ŀ���ʼ����
c  = 3e8;        %����
tr = 2*R0/c;     %��ʱ
k  = B/Tp;       %��Ƶб��
N  = 4096;       %��������
t  = (0:N-1)/fs; %��������
CPI = 512;        %�������   %������ֱ�ʵ��Ĳ����ز�������64��128��256��512�����ֵ��ز���������ʱ���ٶȻ�ӽ�����ֵ�� 
Tr = 100e-6;     %�����ظ�����
v  = 60;         %�����״��ٶ�
lambda = c/f0;   %����


h = waitbar(0,'�����С���');
%% �ز�����
S = zeros(CPI,N);
for n=1:CPI
    tau_m = 2*(R0-n*Tr*v)/c;
    S(n,:) = rectpuls(t-tau_m-Tp/2,Tp) .* exp(1i*pi*k*(t-tau_m-Tp/2).^2) .* exp(-1i*2*pi*f0*tau_m);
end

%% �ز�Ƶ��
fft_Num = N;
f = (0:fft_Num-1) / fft_Num * fs;
for n = 1:CPI
    Spetrum(n,:) = fft( S(n,:),fft_Num);
end

%% �ο��ź�
Sr = rectpuls(t-Tp/2,Tp) .* exp(1i*pi*k*(t-Tp/2).^2);
Sr_fft = fft(Sr,fft_Num);

%% ��������ѹ
Scomp = zeros(CPI,N);
for n=1:CPI
    Scomp(n,:) = ifft(Spetrum(n,:) .* conj(Sr_fft));
end

figure(1);
imagesc(t*c/2,1:CPI,abs(Scomp));
figure(2);
plot(t*c/2,abs(Scomp(3,:))); title('��������ѹ')
figure(3)
mesh(t*c/2,1:CPI,abs(Scomp));

%% PD����
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
imagesc(L,V,abs(PD));xlabel('����(m)');ylabel('�ٶ�(m/s)');title('��������մ���');

figure(4);  
mesh(L,V,abs(PD));

close(h); % ע��������close����

[row,col] = find( abs(PD) == max(max(abs(PD))));

V_point = V(row)   %�ٶ�����why���ٶȷֱ���Ӧ����ô��
R_point = L(col)  




