%%%��άֱ�����
%%%�����������
%�ڵ�
mu=[0 0];  %��ֵ
S=[1 2.5;2.5 8];  %Э����
data1=mvnrnd(mu,S,200);   %����200����˹�ֲ�����
%���
mu=[2 2];
S=[8 0;0 8];
data2=mvnrnd(mu,S,100);     %����100����������
%�ϲ�����
data=[data1',data2'];
iter = 100; 
 
 %%% �������ݵ�
 figure;plot(data(1,:),data(2,:),'o');hold on; % ��ʾ���ݵ�
 number = size(data,2); % �ܵ���
 bestParameter1=0; bestParameter2=0; % ���ƥ��Ĳ���
 sigma = 1;
 pretotal=0;     %�������ģ�͵����ݵĸ���
 
 for i=1:iter
 %%% ���ѡ��������
     idx = randperm(number,2); 
     sample = data(:,idx); 
 
     %%%���ֱ�߷��� y=ax+b
     line = zeros(1,3);
     x = sample(:, 1);
     y = sample(:, 2);
 
     k=(y(1)-y(2))/(x(1)-x(2));      %ֱ��б��
     b = y(1) - k*x(1);
     line = [k -1 b];
 
     mask=abs(line*[data; ones(1,size(data,2))]);    %��ÿ�����ݵ����ֱ�ߵľ���
     total=sum(mask<sigma);              %�������ݾ���ֱ��С��һ����ֵ�����ݵĸ���
 
     if total>pretotal            %�ҵ��������ֱ�������������ֱ��
         pretotal=total;
         bestline=line;          %�ҵ���õ����ֱ��
    end  
 end
 %��ʾ���������ϵ�����
mask=abs(bestline*[data; ones(1,size(data,2))])<sigma;    
hold on;
k=1;
for i=1:length(mask)
    if mask(i)
        inliers(1,k) = data(1,i);
        k=k+1;
        plot(data(1,i),data(2,i),'+');
    end
end
 
%%% �������ƥ������
bestParameter1 = -bestline(1)/bestline(2);
bestParameter2 = -bestline(3)/bestline(2);
xAxis = min(inliers(1,:)):max(inliers(1,:));
yAxis = bestParameter1*xAxis + bestParameter2;
plot(xAxis,yAxis,'r-','LineWidth',2);
title(['bestLine:  y =  ',num2str(bestParameter1),'x + ',num2str(bestParameter2)]);