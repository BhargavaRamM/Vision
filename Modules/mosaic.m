function [m] = Mos()

%{
%imageDir = dir(fullfile('C:', 'Users','Karthik Kikkuru','Documents', 'MATLAB','4','.png'));
imageDir = dir('C:\Users\Karthik Kikkuru\Documents\MATLAB\4\*.png');
%imcell = cell(1,numel(imageDir));
%numel(imageDir);

for i = 1:(imageDir)
  I = imread(imageDir(i).name);
end
%}
srcFiles = dir('C:\Users\Karthik Kikkuru\Documents\MATLAB\1\*.jpg');  % the folder in which ur images exists
for i = 1 : length(srcFiles)
    filename = strcat('C:\Users\Karthik Kikkuru\Documents\MATLAB\1\',srcFiles(i).name);
    %I = imread(filename);
    %figure, imshow(I);
end
p = imread(srcFiles(1).name);
q = imread(srcFiles(2).name);
r = imread(srcFiles(3).name);
m = Mosaic(p,q);
%a = Mosaic(m,r);
for i = 2:length(srcFiles)-1
    %I = imread(srcFiles(i).name);
    J = imread(srcFiles(i+1).name);
    
     m = Mosaic(m,J);
end
    
        %I = imread('1.jpg');
        %J = imread('2.jpg');
        %mos = data{1};
        
       % out = I;
        
      imshow(m);
       
        
end


function out = Mosaic(I,J)

%I = imread('1.jpg');
%J = imread('2.jpg');
I = im2double(I);
J = im2double(J);
[r1,c1,z1] = size(I);
[r2,c2,z2] = size(J);
imshow(I);
[x1 y1] = ginput(4);
figure; imshow(J);
[x2 y2] = ginput(4);
syms a b c d e f;

A = [a b c;d e f;0 0 1];
AT = transpose(A);

for i = 1:3
    B(:,i) = [x1(i), y1(i),1];
end
BT = transpose(B);

for i = 1:3
    C(:,i) = [x2(i), y2(i),1];
end
CT = transpose(C);

Y=inv(B*BT);
Z=BT*Y;
Transformationmatrix = round(C*Z)




if size(x2,1)==3
    Z  = [ x2'  y2' ; y2' -x2' ; 1 1 1 0 0 0  ; 0 0 0 1 1 1 ]';
end
if size(x2,1)==4
    Z = [ x2'  y2' ; y2' -x2' ; 1 1 1 1 0 0 0 0  ; 0 0 0 0 1 1 1 1 ]';
end
X = [x1;y1];

P = Z\X;

a = P(1);
b = P(2);
c = P(3);
d = P(4);

T = [a b c;-b a d;0 0 1];
C = T*[1 1 c2 c2;1 r2 r2 1;1 1 1 1];
size(C);
Xr = min([C(1,:) 0]) : max([C(1,:) c1]);
Yr = min([C(2,:) 0]) : max([C(2,:) r1]);
[XP,YP] = ndgrid(Xr,Yr);
[cp rp] = size(XP);

X = T \ [ XP(:) YP(:) ones(cp*rp,1) ]';


xI = reshape( X(1,:),cp,rp)';
yI = reshape( X(2,:),cp,rp)';
Mp(:,:,1) = interp2(J(:,:,1), xI, yI, '*bilinear');
Mp(:,:,2) = interp2(J(:,:,2), xI, yI, '*bilinear');
Mp(:,:,3) = interp2(J(:,:,3), xI, yI, '*bilinear');


U =  -round( [ min( [ C(1,:) 0 ] ) min( [ C(2,:) 0 ] ) ] );
Mp(1+U(2):r1+U(2),1+U(1):c1+U(1),:) = double(I(1:r1,1:c1,:));


out = Mp;
imshow(out);



end

