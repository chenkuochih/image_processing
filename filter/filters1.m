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
subplot(221);imshow(G);title('ԭʼ�Ҷ�ͼ��');
subplot(222);imshow(J);title('��ӽ�������ͼ��');
subplot(223);imshow(J1);title('��Ӻ�������ͼ��');
subplot(224);imshow(J2);title('���������ͼ��');

figure(2);
%ԭʼͼƬ
subplot(2,2,1);
imshow(I);
title('ԭʼͼƬ');
data=J;%����ͼƬ��ͼƬ���Ƶ���ǰ�ļ���
subplot(2,2,2);
imshow(data);
title('��������ͼƬ');
%��ֵ�˲�
mdata=medfilt2(data);
subplot(2,2,3);
imshow(mdata);
title('��ֵ�˲�');
%��ֵ�˲�
h=fspecial('average');%����һ����ֵģ��
fdata=imfilter(data,h);%ǰ����ͼƬ��������ģ��
subplot(2,2,4);
imshow(fdata);
title('��ֵ�˲�');


figure(3);
%ԭʼͼƬ
subplot(2,2,1);
imshow(I);
title('ԭʼͼƬ');
subplot(2,2,2);
imshow(J);
title('��������ͼƬ');
%��ֵ�˲�
Jmin= ordfilt2(J,1,ones(3,3));
subplot(2,2,3)
imshow(Jmin);
title('��Сֵ�˲�');
%��ֵ�˲�
Jmax= ordfilt2(J,9,ones(3,3));
subplot(2,2,4)
imshow(Jmax);
title('���ֵ�˲�');
