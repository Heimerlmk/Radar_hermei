%% ��Բ

clc; clear all; close all;

%% 
delta_x = 5/4;        %����ֱ���
delta_y = 2/4;        %��λ��ֱ���
Circle_count = 1:1:20;  %Բ�����⻷

rho = Circle_count*delta_x;
%theta = 0:0.0750:2*pi; %�Ƕȷֱ����µ� theta = lambda / D = 0.0750;
theta = 0:0.005:2*pi; 
%polar(theta,r);
for i = 1:length(Circle_count)
    r=linspace(1,1,length(theta))*rho(i);
    [x(i,:),y(i,:)] = pol2cart(theta,r);
end
X = x(:);
Y = y(:);

Xmin = 0;
Yc   = 10000;
% 
point_Num = length(X); 
Ptarget = zeros(point_Num,3);
% 
Ptarget(:,1) = Xmin;
Ptarget(:,2) = Yc;
Ptarget(:,3) = 1;
%      
%       
% %% ֻ���� y=kx ���Σ�
% % k = 0;
% % dx = 0:delta_x:(point_Num-1) * delta_x;
% % dx = dx';
% % dy = (k * dx)./delta_x .* delta_y;
Ptarget(:,1) = Ptarget(:,1) + Y;
Ptarget(:,2) = Ptarget(:,2) + X;



