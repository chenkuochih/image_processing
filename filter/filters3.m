%% �� ���ں��� ʹ�ô����˲���BSF��
clear all;
close all;
%% ����ԭʼ�ź�
N = 500; %ԭʼ�źų��ȣ�����
Fs = 500; %����Ƶ�ʣ�Hz
Dt = 1/Fs; %�������ʱ�䣺s
t = [0:N-1]*Dt; %ʱ�����У�s
f1 = 10;f2 = 50;f3 = 70; %ԭʼ�ź�Ƶ��
y = cos(2*f1*t*pi)+cos(2*f2*t*pi)+cos(2*f3*t*pi);
subplot(2,2,1);plot(t,y); %ʱ���ź�ͼ
title('ԭʼ�ź�-ʱ��');xlabel('ʱ��/s');ylabel('��ֵ/v');
% xlim([0 12]);ylim([-1.5 1.5]);
%% FFT�任
FN = N; %FFTִ�г��ȣ�����
f0 = 1/(Dt*FN); %��Ƶ
Fy = fft(y);  %��ʱ���źŽ���FFT�任
mag = abs(Fy);
n = 0:FN-1;
Ff = n*f0;  %Ƶ������
subplot(2,2,2);plot(Ff,mag); %����ԭʼ�źŵ����ͼ
title('ԭʼ�ź�-Ƶ��');xlabel('Ƶ��/Hz');ylabel('���');
% ylim([0 0.8]);xlim([0 50]);
%% �����˲���BSF
BN = N;
Bn = 0:BN-1;
fmax = 60;
fmin = 40;
By = zeros(1, length(y));
for m = Bn
    if (m*Fs/BN>fmin & m*Fs/BN<fmax) |  (m*Fs/BN>(Fs-fmax) & m*Fs/BN<(Fs-fmin));
        By(m+1) = 0;
    else
        if m<BN-1;
            By(m+1) = Fy(m+1);
        end
    end
end
subplot(2,2,4);plot(Ff,abs(By)*2/BN);
title('�����˲�-Ƶ�����Ƶ��40~60Hz��');xlabel('Ƶ��/Hz');ylabel('���');
subplot(2,2,3);plot(t,real(ifft(By)));
title('�����˲�-ʱ�����Ƶ��40~60Hz��');xlabel('ʱ��/s');ylabel('��ֵ/v');