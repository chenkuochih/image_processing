clc;
close all;
%ԭʼͼƬ
data=imread('a.jpg');%����ͼƬ��ͼƬ���Ƶ���ǰ�ļ���
subplot(221);
imshow(data);
title('ԭʼͼƬ');
%��ֵ�� 
gdata=rgb2gray(data);
subplot(222);
imshow(gdata);
title('��ֵ��ͼƬ');
%��ֵ�˲�
mdata=medfilt2(gdata);
subplot(223);
imshow(mdata);
title('��ֵ�˲�');
%��ֵ�˲�
h=fspecial('average');%����һ����ֵģ��
fdata=imfilter(gdata,h);%ǰ����ͼƬ��������ģ��
subplot(224);
imshow(fdata);
title('��ֵ�˲�');
%��ʾֱ��ͼ imhist
figure;
subplot(221);
imhist(gdata,128);
axis([0 50 0 15000]);
title('ԭʼͼƬֱ��ͼ')
subplot(223);
imhist(mdata);
axis([0 50 0 15000]);
title('��ֵ�˲�ֱ��ͼ')
subplot(224)
imhist(fdata);
axis([0 50 0 15000]);
title('��ֵ�˲�ֱ��ͼ')
