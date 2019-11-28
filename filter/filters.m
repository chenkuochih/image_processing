clc;
close all;
%原始图片
data=imread('a.jpg');%读入图片，图片复制到当前文件夹
subplot(221);
imshow(data);
title('原始图片');
%二值化 
gdata=rgb2gray(data);
subplot(222);
imshow(gdata);
title('二值化图片');
%中值滤波
mdata=medfilt2(gdata);
subplot(223);
imshow(mdata);
title('中值滤波');
%均值滤波
h=fspecial('average');%创建一个均值模板
fdata=imfilter(gdata,h);%前面是图片，后面是模板
subplot(224);
imshow(fdata);
title('均值滤波');
%显示直方图 imhist
figure;
subplot(221);
imhist(gdata,128);
axis([0 50 0 15000]);
title('原始图片直方图')
subplot(223);
imhist(mdata);
axis([0 50 0 15000]);
title('中值滤波直方图')
subplot(224)
imhist(fdata);
axis([0 50 0 15000]);
title('均值滤波直方图')
