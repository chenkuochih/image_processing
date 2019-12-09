[I,map]=imread('a.jpg ');
[H,W]=size(I);
M=double(I);
J=M;
for i=2:H-1
for j=2:W-1
  J(i,j)=abs(M(i-1,j+1)-M(i-1,j-1)+2*M(i,j+1)-2*M(i,j-1)+M(i+1,j+1)-M(i+1,j-1))+abs(M(i-1,j-1)-M(i+1,j-1)+2*M(i-1,j)-2*M(i+1,j)+M(i-1,j+1)-M(i+1,j+1));
end
end
figure(1);
subplot(1,2,1);imshow(I);title('original');
subplot(1,2,2);imshow(uint8(J));title('sobel');

image=imread('a.jpg ');
image=rgb2gray(image); 
image=double(image);
figure(2);
subplot(1,2,1),imshow(image,[]);    
title('Road Image'); 
thresh=[0.02,0.2];  
sigma=2;
BW = edge(image,'canny',thresh,sigma);

%-----------------得到参数空间------------------
[H, theta, rho]= hough(BW,'RhoResolution', 0.5,'ThetaResolution',0.5);      
    
peak=houghpeaks(H,5); %求极值点   
lines=houghlines(BW,theta,rho,peak); %返回原图直线信息 
subplot(1,2,2),imshow(BW,[]),title('Hough Transform Detect Result'),hold on    
for k=1:length(lines)    
    xy=[lines(k).point1;lines(k).point2];    
    plot(xy(:,1),xy(:,2),'LineWidth',4);    
end    
