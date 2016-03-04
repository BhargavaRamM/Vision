function [] = eartest()
%EDGE DETECTION:


D = dir('C:\Users\Karthik Kikkuru\Documents\MATLAB\EAR TEST\*.jpg');
%D = dir('C:\Users\Karthik Kikkuru\Documents\MATLAB\EAR TEST\002_front_ear.jpg');
%imcell = cell(1,numel(D));
a=[1:8];
k=0;
n=1;

for i = 1:1:numel(D)
for p=1:1:25
    
    k=k+1;

  I = imread(D(i).name);
I=imrotate(I,p,'bilinear');
%figure;imshow(I);


I=rgb2gray(I);
h=fspecial('gaussian',12 ,10);
final=imfilter(I,h);
%final=imfilter(final,h);
%final=imfilter(final,h);

edgedetect=edge(final,'canny', [0.08,0.11]);

%figure;imshow(edgedetect);

%CENTRE OF THE IMAGE
[r, c] = size(edgedetect);
centerX = int16(c/2);
centerY = int16(r/2);





%NEAREST EDGE(X):                                                   

for j = centerX:-1:1
	if edgedetect(centerY, j) == 1
		NearestedgeX= j;
		break;
	end
end


%FARTHEST EDGE(X):

%N=0;
for j = centerX:-1:1
       if edgedetect(centerY, j) == 1
         FarthestedgeX=j;
         %N=N+1;
       end
end



%NEAREST EDGE(Y):

for j = centerY:-1:1
	if edgedetect(j,centerX) == 1
		NearestedgeY=j;
		break;
	end
end

%FARTHEST EDGE(Y)

for j = centerY:-1:1
       if edgedetect(j,centerX) == 1
          FarthestedgeY=j;
         % N=N+1;
       end
end


a1=centerX;
b1=NearestedgeX;
d1=(a1-b1);
NearestdistX=d1;

a2=centerY;
b2=NearestedgeY;
d2=(a2-b2);
NearestdistY=d2;

x1=centerX;
y1=FarthestedgeX;
d3=(x1-y1);
FarthestdistX=d3;

x2=centerY;
y2=FarthestedgeY;
d4=(x2-y2);
FarthestdistX=d4;

if(d1 == 0)
    d1=1;
end

if(d2 == 0)
    d2=1;
end

d1=double(d1);
d2=double(d2);
d3=double(d3);
d4=double(d4);

product = d1*d2*d3*d4;
ratio = (d1/d2)*(d3/d4);

if (isnan(ratio))
    %figure;imshow(D(i).name);
end

%a(k)=ratio;
a(k)=product;
m=(20:4);

m=[d1,d2,d3,d4];

%disp(product);



end
csvwrite('test1.csv',a);
end
%end
