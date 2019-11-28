clear;clc;close all
I=imread('a.jpg');  %����ͼƬ
I=rgb2gray(I);  %rgbͼת���ɻҶ�ͼ
subplot(2,3,1);imshow(I);
title('ԭͼ') 
I1=imnoise(I,'salt & pepper',0.02);  %ԭͼ��ӽ����������õ��������֮���ͼI1
subplot(2,3,2);imshow(I1)
title('��ӽ�������') 

%ά���˲�
I4=wiener2(double(I1),[5 5]);  %��I1����ά���˲�
subplot(2,3,3);imshow(uint8(I4))
title('ά���˲�')

%Լ����С���˷�
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
%subplot(2,3,7), imshow(blurred_noisy)��title('ģ��ģ��������')
% Try restoration using  Home Made Constrained Least Squares Filtering.
p = [0 -1 0;-1 4 -1;0 -1 0];
P = psf2otf(p,[hei,wid]);
gama = 0.001;
If = fft2(blurred_noisy);
numerator = conj(Pf);
denominator = Pf.^2 + gama*(P.^2);
subplot(2,3,4); imshow(deconvreg(blurred_noisy, PSF,0)); title('Լ����С���˷�');


%���˲�
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
subplot(2,3,5);imshow(uint8(I2));title('ȫ���˲���ԭͼ');