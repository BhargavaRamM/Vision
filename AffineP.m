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
%out = final1;

C = final1*[1 1 c2 c2;1 r2 r2 1;1 1 1 1];
Xpr = min([C(1,:) 0]) : max([C(1,:) c1]);
Ypr = min([C(2,:) 0]) : max([C(2,:) r1]);
[XP,YP] = ndgrid(Xpr,Ypr);
[cp rp] = size(XP);

X = final1 \ [ XP(:) YP(:) ones(cp*rp,1) ]';  % warp

%clear Ip;
xI = reshape( X(1,:),cp,rp)';
yI = reshape( X(2,:),cp,rp)';
Ip(:,:,1) = interp2(I2(:,:,1), xI, yI, '*bilinear'); % red
Ip(:,:,2) = interp2(I2(:,:,2), xI, yI, '*bilinear'); % green
Ip(:,:,3) = interp2(I2(:,:,3), xI, yI, '*bilinear'); % blue

% offset and copy original image into the warped image
offset =  -round( [ min( [ C(1,:) 0 ] ) min( [ C(2,:) 0 ] ) ] );
Ip(1+offset(2):r1+offset(2),1+offset(1):c1+offset(1),:) = double(I1(1:r1,1:c1,:));

% show the result
out=Ip;

end