%%ƽ��
clc;clear all;close all;

%% ��������
delta_x = 5;        %����ֱ���
delta_y = 2;        %��λ��ֱ���

dx = 5/4;        %���벽��
dy = 2/4;        %��λ�򲽽�

Xmin = 0;
Yc   = 10000;       %���ĵ�����

rectangle_wide   = 20*delta_x; %���ο�
rectangle_length = 20*delta_y; %���γ�

%rectangle_point_x = zeros(rectangle_wide/dy,rectangle_length/dx);
%rectangle_point_y = zeros(rectangle_wide/dy,rectangle_length/dx);

% ��ɢ���ε�����
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

X = rectangle_point_x(:);   %����X����
Y = rectangle_point_y(:);   %����Y����

point_Num = length(X); 
Ptarget = zeros(point_Num,3);

%% д�����
Ptarget(:,1) = Xmin;
Ptarget(:,2) = Yc;
Ptarget(:,3) = 1;       

Ptarget(:,1) = X;
Ptarget(:,2) = Y;

msgbox('�������');



