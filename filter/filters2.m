%% ����ͼ��I
I=imread('a.jpg');
%ת��Ϊ�Ҷ�ͼIg
Ig=rgb2gray(I);
%���ܶ�Ϊ0.2�Ľ���������Ⱦ��ͼ��Inoise
Inoise=imnoise(Ig,'salt & pepper',0.2);
%�����Ǳ�����Ϊ0.2�ĸ�˹������Ⱦ��ͼ��Inoise
%Inoise=imnoise(Ig,'gaussian',0.2);
%��ʾԭͼ�ĻҶ�ͼIg������ͼ��Inoise
subplot(2,2,1),imshow(Ig);xlabel('a.ԭʼ�Ҷ�ͼ��');
subplot(2,2,2),imshow(Inoise);xlabel('b.��������Ⱦ��ͼ��');

%% �������
%��ȡͼ��ߴ�:Im,In
[Im,In]=size(Inoise);
%��ʼ���ڳߴ�:nmin*nmin(���ڳߴ�ʼ��ȡ����)
nmin=3;
%��󴰿ڳߴ�:nmax*nmax
nmax=9;
%���帴ԭ���ͼ��Imf
Imf=Inoise;
%Ϊ�˴���ͼ��ı߽�㣬�轫ͼ������
%��Ϊ���ڳߴ��ǵ��Եģ����Խ�Inoise�̶����䵽���:I_ex[(Im+(nmax-1))*(In+(nmax-1))]
I_ex=[zeros((nmax-1)/2,In+(nmax-1));zeros(Im,(nmax-1)/2),Inoise,zeros(Im,(nmax-1)/2);zeros((nmax-1)/2,In+(nmax-1))];
%% ����Ӧ�˲�����
%����ͼ��Inoise�е�ÿһ��
for x=1:Im
    for y=1:In
        for n=nmin:2:nmax
                %ͼ��Inoise�е�ĳ��(x,y)������Sxy����Ӧ��I_ex��Ϊ(x+[(nmax-1)/2-(n-1)/2]:x+[(nmax-1)/2-(n-1)/2]+(n-1),y+(nmax-1)/2-(n-1)/2:y+[(nmax-1)/2-(n-1)/2]+(n-1)) 
                Sxy=I_ex(x+(nmax-1)/2-(n-1)/2:x+(nmax-1)/2+(n-1)/2,y+(nmax-1)/2-(n-1)/2:y+(nmax-1)/2+(n-1)/2);
                Smax=max(max(Sxy));%������������ص����ֵ
                Smin=min(min(Sxy));%������������ص���Сֵ
                Smed=median(median(Sxy));%������������ص���ֵ
                %�ж���ֵ�Ƿ���������
                if Smed>Smin && Smed<Smax
                   %����ֵ�ȴ�����Сֵ��С�����ֵ������
                   %�ǣ����˳���if��䣬���󴰿ڳߴ磬�ٴ��ж�
                   %���ǣ����жϸõ��ԭֵ�ǲ���������
                   if Imf(x,y)<=Smin || Imf(x,y)>=Smax
                      %���õ��ԭֵ�ȴ�����Сֵ��С�����ֵ������ 
                      %���ǣ������ԭֵ������������
                      %�ǣ��������ֵ
                      Imf(x,y)=Smed;
                   end
                   break
                   %��������ٽ���ѭ���ж�
                end
        end
        %��n=maxʱ�������ֵ
        Imf(x,y)=Smed;
    end
end
subplot(2,2,3),imshow(Imf);xlabel('c.����Ӧ��ֵ�˲������˲�Ч��');
%% ����ͨ��ֵ�˲����ĶԱ�
Imf1=medfilt2(Inoise,[3,3]);
Imf2=medfilt2(Imf1,[3,3]);
subplot(2,2,4),imshow(Imf2);xlabel('d.��ͨ��ֵ�˲��������˲�Ч��');