clear;clc;close all
I=imread('a.jpg');  %读入图片
I=rgb2gray(I);  %rgb图转换成灰度图
subplot(2,3,1);imshow(I);
title('原图') 
I1=imnoise(I,'salt & pepper',0.02);  %原图添加椒盐噪声，得到添加噪声之后的图I1
subplot(2,3,2);imshow(I1)
title('添加椒盐噪声') 

%维纳滤波
I4=wiener2(double(I1),[5 5]);  %对I1进行维纳滤波
subplot(2,3,3);imshow(uint8(I4))
title('维纳滤波')

%约束最小二乘方
[hei,wid,~] = size(I);
LEN = 21;
THETA = 11;
PSF = fspecial('motion', LEN, THETA);
blurred = imfilter(I, PSF, 'conv', 'circular');
If = fft2(blurred);
Pf = psf2otf(PSF,[hei,wid]);
% Simulate additive noise.
noise_mean = 0;
noise_var = 0.00001;
blurred_noisy = imnoise(blurred, 'gaussian',noise_mean, noise_var);
%subplot(2,3,7), imshow(blurred_noisy)；title('模拟模糊和噪声')
% Try restoration using  Home Made Constrained Least Squares Filtering.
p = [0 -1 0;-1 4 -1;0 -1 0];
P = psf2otf(p,[hei,wid]);
gama = 0.001;
If = fft2(blurred_noisy);
numerator = conj(Pf);
denominator = Pf.^2 + gama*(P.^2);
subplot(2,3,4); imshow(deconvreg(blurred_noisy, PSF,0)); title('约束最小二乘方');


%逆滤波
[m,n]=size(I);
F=fftshift(fft2(I));
k=0.0025;
for u=1:m
    for v=1:n
        H(u,v)=exp((-k)*(((u-m/2)^2+(v-n/2)^2)^(5/6)));
    end
end
G=F.*H;
I0=real(ifft2(fftshift(G)));
I1=imnoise(uint8(I0),'gaussian',0,0.001);
F0=fftshift(fft2(I1));
F1=F0./H;
I2=ifft2(fftshift(F1));
subplot(2,3,5);imshow(uint8(I2));title('全逆滤波复原图');