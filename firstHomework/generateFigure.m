function [I] = generateFigure(imgW,imgH)
%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
x = 0:pi/100:2*pi;
y1 = sin(x);
y2 = cos(x);
y3 = x.^2;
figure(1),plot(x,y1, 'r' ,x,y2, 'g' ,x,y3, 'b' ),title('test');
set (1,'position',[100,100,imgW,imgH] );   % ����ͼ��߾�ʹ�С
print(1, '-dpng', 'test');
I = imread('test.png');
end

