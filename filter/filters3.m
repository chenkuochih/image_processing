%% 对 周期函数 使用带阻滤波（BSF）
clear all;
close all;
%% 构建原始信号
N = 500; %原始信号长度：点数
Fs = 500; %采样频率：Hz
Dt = 1/Fs; %采样间隔时间：s
t = [0:N-1]*Dt; %时间序列：s
f1 = 10;f2 = 50;f3 = 70; %原始信号频率
y = cos(2*f1*t*pi)+cos(2*f2*t*pi)+cos(2*f3*t*pi);
subplot(2,2,1);plot(t,y); %时域信号图
title('原始信号-时域');xlabel('时间/s');ylabel('幅值/v');
% xlim([0 12]);ylim([-1.5 1.5]);
%% FFT变换
FN = N; %FFT执行长度：点数
f0 = 1/(Dt*FN); %基频
Fy = fft(y);  %对时域信号进行FFT变换
mag = abs(Fy);
n = 0:FN-1;
Ff = n*f0;  %频率序列
subplot(2,2,2);plot(Ff,mag); %绘制原始信号的振幅图
title('原始信号-频域');xlabel('频率/Hz');ylabel('振幅');
% ylim([0 0.8]);xlim([0 50]);
%% 带阻滤波器BSF
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
title('带阻滤波-频域（阻带频率40~60Hz）');xlabel('频率/Hz');ylabel('振幅');
subplot(2,2,3);plot(t,real(ifft(By)));
title('带阻滤波-时域（阻带频率40~60Hz）');xlabel('时间/s');ylabel('幅值/v');