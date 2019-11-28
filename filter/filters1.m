I=imread('a.jpg');
G=rgb2gray(I);
J = imnoise(G,'salt & pepper',0.05);
J1= imnoise(G,'salt & pepper',0.05);
J2= imnoise(G,'salt & pepper',0.05);
[M,N]=size(J);
for i=1:M
for j=1:N
if(J1(i,j)==255)
J1(i,j)=0;
else
J1(i,j)=J1(i,j);
end
end
end
for i=1:M
for j=1:N
if(J2(i,j)==0)
J2(i,j)=255;
else
J2(i,j)=J2(i,j);
end
end
end
A= meshgrid(1:3, 1:3);
A1= meshgrid(1:5, 1:5);
A2= meshgrid(1:8, 1:8);
figure(1)
subplot(221);imshow(G);title('原始灰度图像');
subplot(222);imshow(J);title('添加椒盐噪声图像');
subplot(223);imshow(J1);title('添加胡椒噪声图像');
subplot(224);imshow(J2);title('添加盐噪声图像');

figure(2);
%原始图片
subplot(2,2,1);
imshow(I);
title('原始图片');
data=J;%读入图片，图片复制到当前文件夹
subplot(2,2,2);
imshow(data);
title('椒盐噪声图片');
%中值滤波
mdata=medfilt2(data);
subplot(2,2,3);
imshow(mdata);
title('中值滤波');
%均值滤波
h=fspecial('average');%创建一个均值模板
fdata=imfilter(data,h);%前面是图片，后面是模板
subplot(2,2,4);
imshow(fdata);
title('均值滤波');


figure(3);
%原始图片
subplot(2,2,1);
imshow(I);
title('原始图片');
subplot(2,2,2);
imshow(J);
title('椒盐噪声图片');
%中值滤波
Jmin= ordfilt2(J,1,ones(3,3));
subplot(2,2,3)
imshow(Jmin);
title('最小值滤波');
%均值滤波
Jmax= ordfilt2(J,9,ones(3,3));
subplot(2,2,4)
imshow(Jmax);
title('最大值滤波');
