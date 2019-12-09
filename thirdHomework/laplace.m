I=imread('a.jpg');
[H,W]=size(I);
M=double(I);
J=M;
for i=2:H-1
for j=2:W-1
J(i,j)=4*M(i,j)-[M(i+1,j)+M(i-1,j)+M(i,j+1)+M(i,j-1)];
end
end
subplot(1,2,1);imshow(I);title('original');
subplot(1,2,2);imshow(uint8(J));title('laplace');