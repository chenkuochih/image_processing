I=imread('a.jpg');         %��ȡ��ǰ·���µ�ͼƬ
subplot(2,2,1);
imshow(I);
title('ԭʼͼ��');
I1=rgb2gray(I);
subplot(2,2,2);
imshow(I1);
title('�Ҷ�ͼ��');
I2=edge(I1,'log');
subplot(2,2,3);
imshow(I2);
title('log���ӷָ���');