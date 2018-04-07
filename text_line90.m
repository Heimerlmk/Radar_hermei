%% 画直线
clc; clear all; close all;
%point_Num = 100;
% k = 2;      %直线斜率
% b = 20;     %直线截距
% x = 10:10:100;   %步进距离
% y = k*x + b;     %直线
% plot(y);
% axis([0 11 0 300]);
Xmin = 0;
Yc   = 10000;

delta_x = 5/4;
delta_y = 2/4;
point_Num = 100; 
 Ptarget=[Xmin+0*delta_x,Yc,1                  %目标点信息
          Xmin+1*delta_x,Yc,1                  %
          Xmin+2*delta_x,Yc,1                  %   
          Xmin+3*delta_x,Yc,1                  %   
          Xmin+4*delta_x,Yc,1                  %   
          Xmin+5*delta_x,Yc,1                  %
          Xmin+6*delta_x,Yc,1                  %
          Xmin+7*delta_x,Yc,1                  %   
          Xmin+8*delta_x,Yc,1                  %
          Xmin+9*delta_x,Yc,1                  %
          
          Xmin+10*delta_x,Yc,1                  %目标点信息
          Xmin+11*delta_x,Yc,1                  %
          Xmin+12*delta_x,Yc,1                  %   
          Xmin+13*delta_x,Yc,1                  %   
          Xmin+14*delta_x,Yc,1                  %   
          Xmin+15*delta_x,Yc,1                  %
          Xmin+16*delta_x,Yc,1                  %
          Xmin+17*delta_x,Yc,1                  %   
          Xmin+18*delta_x,Yc,1                  %
          Xmin+19*delta_x,Yc,1                  %
          
         Xmin+20*delta_x,Yc,1                  %目标点信息
          Xmin+21*delta_x,Yc,1                  %
          Xmin+22*delta_x,Yc,1                  %   
          Xmin+23*delta_x,Yc,1                  %   
          Xmin+24*delta_x,Yc,1                  %   
          Xmin+25*delta_x,Yc,1                  %
          Xmin+26*delta_x,Yc,1                  %
          Xmin+27*delta_x,Yc,1                  %   
          Xmin+28*delta_x,Yc,1                  %
          Xmin+29*delta_x,Yc,1                  %
          Xmin+30*delta_x,Yc,1                  %目标点信息
          Xmin+31*delta_x,Yc,1                  %
          Xmin+32*delta_x,Yc,1                  %   
          Xmin+33*delta_x,Yc,1                  %   
          Xmin+34*delta_x,Yc,1                  %   
          Xmin+35*delta_x,Yc,1                  %
          Xmin+36*delta_x,Yc,1                  %
          Xmin+37*delta_x,Yc,1                  %   
          Xmin+38*delta_x,Yc,1                  %
          Xmin+39*delta_x,Yc,1                  %
          Xmin+40*delta_x,Yc,1                  %目标点信息
          Xmin+41*delta_x,Yc,1                  %
          Xmin+42*delta_x,Yc,1                  %   
          Xmin+43*delta_x,Yc,1                  %   
          Xmin+44*delta_x,Yc,1                  %   
          Xmin+45*delta_x,Yc,1                  %
          Xmin+46*delta_x,Yc,1                  %
          Xmin+47*delta_x,Yc,1                  %   
          Xmin+48*delta_x,Yc,1                  %
          Xmin+49*delta_x,Yc,1                  %
          Xmin+50*delta_x,Yc,1                  %目标点信息
          Xmin+51*delta_x,Yc,1                  %
          Xmin+52*delta_x,Yc,1                  %   
          Xmin+53*delta_x,Yc,1                  %   
          Xmin+54*delta_x,Yc,1                  %   
          Xmin+55*delta_x,Yc,1                  %
          Xmin+56*delta_x,Yc,1                  %
          Xmin+57*delta_x,Yc,1                  %   
          Xmin+58*delta_x,Yc,1                  %
          Xmin+59*delta_x,Yc,1                  %
          Xmin+60*delta_x,Yc,1                  %目标点信息
          Xmin+61*delta_x,Yc,1                  %
          Xmin+62*delta_x,Yc,1                  %   
          Xmin+63*delta_x,Yc,1                  %   
          Xmin+64*delta_x,Yc,1                  %   
          Xmin+65*delta_x,Yc,1                  %
          Xmin+66*delta_x,Yc,1                  %
          Xmin+67*delta_x,Yc,1                  %   
          Xmin+68*delta_x,Yc,1                  %
          Xmin+69*delta_x,Yc,1                  %
          Xmin+70*delta_x,Yc,1                  %目标点信息
          Xmin+71*delta_x,Yc,1                  %
          Xmin+72*delta_x,Yc,1                  %   
          Xmin+73*delta_x,Yc,1                  %   
          Xmin+74*delta_x,Yc,1                  %   
          Xmin+75*delta_x,Yc,1                  %
          Xmin+76*delta_x,Yc,1                  %
          Xmin+77*delta_x,Yc,1                  %   
          Xmin+78*delta_x,Yc,1                  %
          Xmin+79*delta_x,Yc,1                  %
          Xmin+80*delta_x,Yc,1                  %目标点信息
          Xmin+81*delta_x,Yc,1                  %
          Xmin+82*delta_x,Yc,1                  %   
          Xmin+83*delta_x,Yc,1                  %   
          Xmin+84*delta_x,Yc,1                  %   
          Xmin+85*delta_x,Yc,1                  %
          Xmin+86*delta_x,Yc,1                  %
          Xmin+87*delta_x,Yc,1                  %   
          Xmin+88*delta_x,Yc,1                  %
          Xmin+89*delta_x,Yc,1                  %
          Xmin+90*delta_x,Yc,1                  %目标点信息
          Xmin+91*delta_x,Yc,1                  %
          Xmin+92*delta_x,Yc,1                  %   
          Xmin+93*delta_x,Yc,1                  %   
          Xmin+94*delta_x,Yc,1                  %   
          Xmin+95*delta_x,Yc,1                  %
          Xmin+96*delta_x,Yc,1                  %
          Xmin+97*delta_x,Yc,1                  %   
          Xmin+98*delta_x,Yc,1                  %
          Xmin+99*delta_x,Yc,1                  %
          
          ];

% Ptarget = zeros(point_Num,3);
% Ptarget(:,1) = Xmin;
% Ptarget(:,2) = Yc;
% Ptarget(:,3) = 1;
%      
%       
% %% 只考虑 y=kx 情形；
% k = 0;
% dx = 0:delta_x:(point_Num-1) * delta_x;
% dx = dx';
% dy = (k * dx)./delta_x .* delta_y;
% Ptarget(:,1) = Ptarget(:,1) + dy;
% Ptarget(:,2) = Ptarget(:,2) + dx;



