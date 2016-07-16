function [out] = AffineP(I,J)
%Read the images
%I1 = imread('1.jpg');
I1=im2double(I);
%I1 = I;
imshow(I1);
[x,y]=ginput(3);
[r1,c1,z1] = size(I1);
%I2 = imread('2.jpg');
%I2 = J;
I2 = im2double(J);
figure,imshow(I2);
[x1,y1]=ginput(3);
[r2,c2,z2] = size(I2);

syms a b c d e f;

%AX=B
A =[a b c;d e f;0 0 1];
AT=transpose(A);

for i = 1:3
    X(:,i) = [x(i),y(i), 1]
end
XT= transpose(X);

for i = 1:3
    B(:,i) = [x1(i);y1(i); 1]
end
BT= transpose(B);

XT*AT==BT;
%Y1 = linsolve(XT,BT);


Y=inv(X*XT);
Z=XT*Y;
final1 = B*Z
out = final1;


end