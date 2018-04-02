%% 画直线
clc; clear all; close all;
%point_Num = 100;
% k = 2;      %直线斜率
% b = 20;     %直线截距
% x = 10:10:100;   %步进距离
% y = k*x + b;     %直线
% plot(y);
% axis([0 11 0 300]);
Xmin = -400;
Yc   = 10000;

delta_x = 5/4;
delta_y = 2/4;
point_Num = 100; 
%  Ptarget=[Xmin,Yc,1                  %目标点信息
%           Xmin,Yc,1                  %
%           Xmin,Yc,1                  %   
%           Xmin,Yc,1                  %   
%           Xmin,Yc,1                  %   
%           Xmin,Yc,1                  %
%           Xmin,Yc,1                  %
%           Xmin,Yc,1                  %   
%           Xmin,Yc,1                  %
%           Xmin,Yc,1                  %
%           Xmin,Yc,1                  %目标点信息
%           Xmin,Yc,1                  %
%           Xmin,Yc,1                  %   
%           Xmin,Yc,1                  %   
%           Xmin,Yc,1                  %   
%           Xmin,Yc,1                  %
%           Xmin,Yc,1                  %
%           Xmin,Yc,1                  %   
%           Xmin,Yc,1                  %
%           Xmin,Yc,1                  %
%           Xmin,Yc,1                  %目标点信息
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
     
      
%% 只考虑 y=kx 情形；
k = 9;
dx = 0:delta_x:(point_Num-1) * delta_x;
dx = dx';
dy = (k * dx)./delta_x .* delta_y;
Ptarget(:,1) = Ptarget(:,1) + dy;
Ptarget(:,2) = Ptarget(:,2) + dx;



