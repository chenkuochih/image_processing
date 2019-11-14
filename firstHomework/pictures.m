function [] = pictures()
%UNTITLED 此处显示有关此函数的摘要
% 此处显示详细说明
% 双线性插值实现
% f(x,y)=w1*p1+w2*p2+w3*p3+w4*p4 p1,p2,p3,p4是与(x,y)最近的四个像素点
% w1,w2,w3,w4分别是对应的权重
% src是原图像（M*N）,dst是目标图像（P*Q）
% 缩放因子是M/P,N/Q
%%双线性内插本质上就是从x方向和y方向分别作了一次线性插值
src = imread('test.png');
% 得到原图像的大小
[M,N,Z] = size(src);
% 设置目标图像的大小是300*300*3
dst = zeros(300,300,3);
[P,Q,H] = size(dst);
scaler_x = M/P;
scaler_y = N/Q;
% 插值实现
for i=1:P
    for j=1:Q
        % 后向映射得到在原图上的大概坐标
        % 注意一般是浮点类型
        x = i*scaler_x;
        y = j*scaler_y;
        % 取得与(x,y)距离最近的4个像素点
        X1 = floor(x);
        X2 = ceil(x);
        Y1 = floor(y);
        Y2 = ceil(y);
        P1_1 = src(X1,Y1,:);
        P1_2 = src(X1,Y2,:);
        P2_1 = src(X2,Y1,:);
        P2_2 = src(X2,Y2,:);
        % 先在x轴方向进行二次线性内插
        fx1 = (X2-x)/(X2-X1).*P1_1+(x-X1)/(X2-X1).*P2_1;
        fx2 = (X2-x)/(X2-X1).*P1_2+(x-X1)/(X2-X1).*P2_2;
        % 在y方向进行一次线性内插
        f = (Y2-y)/(Y2-Y1).*fx1+(y-Y1)/(Y2-Y1).*fx2;
        dst(i,j,:) = f;
    end
end
dst = im2uint8(mat2gray(dst));
figure();
imshow(src)
title('原图像')
figure();
imshow(dst)
title('目标图像300*300*3') 


