function [] = pictures()
%UNTITLED �˴���ʾ�йش˺�����ժҪ
% �˴���ʾ��ϸ˵��
% ˫���Բ�ֵʵ��
% f(x,y)=w1*p1+w2*p2+w3*p3+w4*p4 p1,p2,p3,p4����(x,y)������ĸ����ص�
% w1,w2,w3,w4�ֱ��Ƕ�Ӧ��Ȩ��
% src��ԭͼ��M*N��,dst��Ŀ��ͼ��P*Q��
% ����������M/P,N/Q
%%˫�����ڲ屾���Ͼ��Ǵ�x�����y����ֱ�����һ�����Բ�ֵ
src = imread('test.png');
% �õ�ԭͼ��Ĵ�С
[M,N,Z] = size(src);
% ����Ŀ��ͼ��Ĵ�С��300*300*3
dst = zeros(300,300,3);
[P,Q,H] = size(dst);
scaler_x = M/P;
scaler_y = N/Q;
% ��ֵʵ��
for i=1:P
    for j=1:Q
        % ����ӳ��õ���ԭͼ�ϵĴ������
        % ע��һ���Ǹ�������
        x = i*scaler_x;
        y = j*scaler_y;
        % ȡ����(x,y)���������4�����ص�
        X1 = floor(x);
        X2 = ceil(x);
        Y1 = floor(y);
        Y2 = ceil(y);
        P1_1 = src(X1,Y1,:);
        P1_2 = src(X1,Y2,:);
        P2_1 = src(X2,Y1,:);
        P2_2 = src(X2,Y2,:);
        % ����x�᷽����ж��������ڲ�
        fx1 = (X2-x)/(X2-X1).*P1_1+(x-X1)/(X2-X1).*P2_1;
        fx2 = (X2-x)/(X2-X1).*P1_2+(x-X1)/(X2-X1).*P2_2;
        % ��y�������һ�������ڲ�
        f = (Y2-y)/(Y2-Y1).*fx1+(y-Y1)/(Y2-Y1).*fx2;
        dst(i,j,:) = f;
    end
end
dst = im2uint8(mat2gray(dst));
figure();
imshow(src)
title('ԭͼ��')
figure();
imshow(dst)
title('Ŀ��ͼ��300*300*3') 


