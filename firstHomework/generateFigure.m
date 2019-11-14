function [I] = generateFigure(imgW,imgH)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
x = 0:pi/100:2*pi;
y1 = sin(x);
y2 = cos(x);
y3 = x.^2;
figure(1),plot(x,y1, 'r' ,x,y2, 'g' ,x,y3, 'b' ),title('test');
set (1,'position',[100,100,imgW,imgH] );   % 设置图像边距和大小
print(1, '-dpng', 'test');
I = imread('test.png');
end

