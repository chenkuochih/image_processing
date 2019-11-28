%% 读入图像I
I=imread('a.jpg');
%转化为灰度图Ig
Ig=rgb2gray(I);
%被密度为0.2的椒盐噪声污染的图像Inoise
Inoise=imnoise(Ig,'salt & pepper',0.2);
%或者是被方差为0.2的高斯噪声污染的图像Inoise
%Inoise=imnoise(Ig,'gaussian',0.2);
%显示原图的灰度图Ig和噪声图像Inoise
subplot(2,2,1),imshow(Ig);xlabel('a.原始灰度图像');
subplot(2,2,2),imshow(Inoise);xlabel('b.被噪声污染的图像');

%% 定义参数
%获取图像尺寸:Im,In
[Im,In]=size(Inoise);
%起始窗口尺寸:nmin*nmin(窗口尺寸始终取奇数)
nmin=3;
%最大窗口尺寸:nmax*nmax
nmax=9;
%定义复原后的图像Imf
Imf=Inoise;
%为了处理到图像的边界点，需将图像扩充
%因为窗口尺寸是弹性的，所以将Inoise固定扩充到最大:I_ex[(Im+(nmax-1))*(In+(nmax-1))]
I_ex=[zeros((nmax-1)/2,In+(nmax-1));zeros(Im,(nmax-1)/2),Inoise,zeros(Im,(nmax-1)/2);zeros((nmax-1)/2,In+(nmax-1))];
%% 自适应滤波过程
%遍历图像Inoise中的每一点
for x=1:Im
    for y=1:In
        for n=nmin:2:nmax
                %图像Inoise中的某点(x,y)的领域Sxy，对应在I_ex中为(x+[(nmax-1)/2-(n-1)/2]:x+[(nmax-1)/2-(n-1)/2]+(n-1),y+(nmax-1)/2-(n-1)/2:y+[(nmax-1)/2-(n-1)/2]+(n-1)) 
                Sxy=I_ex(x+(nmax-1)/2-(n-1)/2:x+(nmax-1)/2+(n-1)/2,y+(nmax-1)/2-(n-1)/2:y+(nmax-1)/2+(n-1)/2);
                Smax=max(max(Sxy));%求出窗口内像素的最大值
                Smin=min(min(Sxy));%求出窗口内像素的最小值
                Smed=median(median(Sxy));%求出窗口内像素的中值
                %判断中值是否是噪声点
                if Smed>Smin && Smed<Smax
                   %若中值既大于最小值又小于最大值，则不是
                   %是，则退出该if语句，增大窗口尺寸，再次判断
                   %不是，则判断该点的原值是不是噪声点
                   if Imf(x,y)<=Smin || Imf(x,y)>=Smax
                      %若该点的原值既大于最小值又小于最大值，则不是 
                      %不是，则输出原值，即不作处理
                      %是，则输出中值
                      Imf(x,y)=Smed;
                   end
                   break
                   %有输出则不再进行循环判断
                end
        end
        %当n=max时，输出中值
        Imf(x,y)=Smed;
    end
end
subplot(2,2,3),imshow(Imf);xlabel('c.自适应中值滤波器的滤波效果');
%% 与普通中值滤波器的对比
Imf1=medfilt2(Inoise,[3,3]);
Imf2=medfilt2(Imf1,[3,3]);
subplot(2,2,4),imshow(Imf2);xlabel('d.普通中值滤波器两次滤波效果');