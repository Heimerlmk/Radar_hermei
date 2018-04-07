%%��������������
clc;clear all;clear all;

%% ��������
Xmin = 0;
Yc   = 10000;           %���ĵ�����
                                       
delta_y = 5;            %������ֱ���
delta_x = 2;            %��λ��ֱ���

dx = delta_x/4;         
dy = delta_y/4;         %�������

Triangle_length = 50*delta_y;   %�����α߳�
%% ��������
YA = Yc - Triangle_length/2; XA = Xmin - sqrt(3)/6 * Triangle_length;
YB = Yc + Triangle_length/2; XB = Xmin - sqrt(3)/6 * Triangle_length;
YC = Yc;                     XC = Xmin + sqrt(3)/3 * Triangle_length;

%% �ȱ������εױ�AB
line_AB_y = YA : dy : YB;
line_AB_x = zeros(1,length(line_AB_y)) + XA;

%% �ȱ����������AC
k_AC = sqrt(3);        %tan(pi/3)
line_AC_y = YA : dy : YC;
line_AC_x = (k_AC * (line_AC_y - YA))./dy * dx + XA;

%line_AC_x(:)=0;
%line_AC_y(:)=0;

%% �ȱ����������CB
k_CB = -sqrt(3);        %tan(pi/3)
line_CB_y = YC : dy : YB;
line_CB_x = (k_CB * (line_CB_y - YC))./dy * dx + line_AC_x(length(line_AC_x));

%line_CB_x(:)=0;
%line_CB_y(:)=0;

%% ����
point_Num = length(line_AB_x)+length(line_AC_x)+length(line_CB_x);
Ptarget = zeros(point_Num,3);
Ptarget(:,3) = 1;

Ptarget(:,1) = [line_AB_x';line_AC_x';line_CB_x'];
Ptarget(:,2) = [line_AB_y';line_AC_y';line_CB_y']; 

msgbox('�������');


