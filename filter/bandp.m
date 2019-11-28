%���������ź�Mix_Signal_1 ���ź� Mix_Signal_2 
Fs = 1000;       %������
N = 1000;        %��������
n = 0:N-1;
t = 0:1/Fs:1-1/Fs;        %ʱ������ 
Signal_Original_1 = sin(2*pi*10*t)+sin(2*pi*20*t)+sin(2*pi*30*t); 
Noise_White_1 = [0.3*randn(1,500), rand(1,500)];        %ǰ500���˹�ֲ�����������500����ȷֲ�������
Mix_Signal_1 = Signal_Original_1 + Noise_White_1;       %����Ļ���ź�

Signal_Original_2 = [zeros(1,100), 20*ones(1,20), -2*ones(1,30), 5*ones(1,80), -5*ones(1,30), 9*ones(1,140), -4*ones(1,40), 3*ones(1,220), 12*ones(1,100), 5*ones(1,20), 25*ones(1,30), 7 *ones(1,190)]; 
Noise_White_2 = 0.5*randn(1,1000);       %��˹������
Mix_Signal_2 = Signal_Original_2 + Noise_White_2;       %����Ļ���ź�
%����ź� Mix_Signal_1  FIR��ͨ�˲�
figure(2);
F = [0:0.05:0.95]; 
A = [1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
b = firls(20,F,A);
Signal_Filter = filter(b,1,Mix_Signal_1);

subplot(4,1,1);       %Mix_Signal_1 ԭʼ�ź�                 
plot(Mix_Signal_1);
axis([0,1000,-4,4]);
title('ԭʼ�ź� ');

subplot(4,1,2);       %Mix_Signal_1 FIR��ͨ�˲��˲����ź�  
plot(Signal_Filter);
axis([0,1000,-5,5]);
title('FIR��ͨ�˲�����ź�');

%����ź� Mix_Signal_2  FIR��ͨ�˲�
F   =  [0:0.05:0.95]; 
A  =  [1 1 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0] ;
b  =  firls(20,F,A);
Signal_Filter = filter(b,1,Mix_Signal_2);
subplot(4,1,3);       %Mix_Signal_2 ԭʼ�ź�                 
plot(Mix_Signal_2);
axis([0,1000,-10,30]);
title('ԭʼ�ź� ');

subplot(4,1,4);       %Mix_Signal_2 FIR��ͨ�˲��˲����ź�  
plot(Signal_Filter);
axis([0,1000,-10,30]);
title('FIR��ͨ�˲�����ź�');
