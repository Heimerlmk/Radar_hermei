%% ��ֱ��
clc; clear all; close all;
%point_Num = 100;
% k = 2;      %ֱ��б��
% b = 20;     %ֱ�߽ؾ�
% x = 10:10:100;   %��������
% y = k*x + b;     %ֱ��
% plot(y);
% axis([0 11 0 300]);
Xmin = -400;
Yc   = 10000;

delta_x = 5/4;
delta_y = 2/4;
point_Num = 100; 
%  Ptarget=[Xmin,Yc,1                  %Ŀ�����Ϣ
%           Xmin,Yc,1                  %
%           Xmin,Yc,1                  %   
%           Xmin,Yc,1                  %   
%           Xmin,Yc,1                  %   
%           Xmin,Yc,1                  %
%           Xmin,Yc,1                  %
%           Xmin,Yc,1                  %   
%           Xmin,Yc,1                  %
%           Xmin,Yc,1                  %
%           Xmin,Yc,1                  %Ŀ�����Ϣ
%           Xmin,Yc,1                  %
%           Xmin,Yc,1                  %   
%           Xmin,Yc,1                  %   
%           Xmin,Yc,1                  %   
%           Xmin,Yc,1                  %
%           Xmin,Yc,1                  %
%           Xmin,Yc,1                  %   
%           Xmin,Yc,1                  %
%           Xmin,Yc,1                  %
%           Xmin,Yc,1                  %Ŀ�����Ϣ
%           Xmin,Yc,1                  %
%           Xmin,Yc,1                  %   
%           Xmin,Yc,1                  %   
%           Xmin,Yc,1                  %   
%           Xmin,Yc,1                  %
%           Xmin,Yc,1                  %
%           Xmin,Yc,1                  %   
%           Xmin,Yc,1                  %
%           Xmin,Yc,1                  %
%           ];

Ptarget = zeros(point_Num,3);
Ptarget(:,1) = Xmin;
Ptarget(:,2) = Yc;
Ptarget(:,3) = 1;
     
      
%% ֻ���� y=kx ���Σ�
k = 9;
dx = 0:delta_x:(point_Num-1) * delta_x;
dx = dx';
dy = (k * dx)./delta_x .* delta_y;
Ptarget(:,1) = Ptarget(:,1) + dy;
Ptarget(:,2) = Ptarget(:,2) + dx;



