%%平板
clc;clear all;close all;

%% 参数设置
delta_x = 5;        %距离分辨率
delta_y = 2;        %方位向分辨率

dx = 5/4;        %距离步进
dy = 2/4;        %方位向步进

Xmin = 0;
Yc   = 10000;       %中心点坐标

rectangle_wide   = 20*delta_x; %矩形宽
rectangle_length = 20*delta_y; %矩形长

%rectangle_point_x = zeros(rectangle_wide/dy,rectangle_length/dx);
%rectangle_point_y = zeros(rectangle_wide/dy,rectangle_length/dx);

% 离散矩形点坐标
% for m = 0:1:rectangle_wide/dy
%     for n = 0:1:rectangle_length/dx
%         rectangle_point_x(m+1,n+1) = Xmin - rectangle_length/2 + n*dx;
%         rectangle_point_y(m+1,n+1) = Yc - rectangle_wide/2 + m*dy;
%     end
% end

% %for m = 0:1:rectangle_wide/dy
%     for n = 0:1:rectangle_length/dx
%         rectangle_point_x(1,n+1) = Xmin - rectangle_length/2 + n*dx;
%         rectangle_point_y(1,n+1) = 10000;%Yc - rectangle_wide/2 + m*dy;
%     end
% %end

for m = 0:1:rectangle_wide/dy
    %for n = 0:1:rectangle_length/dx
        rectangle_point_x(m+1,1) = 0;%Xmin - rectangle_length/2 + n*dx;
        rectangle_point_y(m+1,1) = Yc - rectangle_wide/2 + m*dy;
    %end
end

X = rectangle_point_x(:);   %矩形X坐标
Y = rectangle_point_y(:);   %矩形Y坐标

point_Num = length(X); 
Ptarget = zeros(point_Num,3);

%% 写入点阵
Ptarget(:,1) = Xmin;
Ptarget(:,2) = Yc;
Ptarget(:,3) = 1;       

Ptarget(:,1) = X;
Ptarget(:,2) = Y;

msgbox('计算结束');



