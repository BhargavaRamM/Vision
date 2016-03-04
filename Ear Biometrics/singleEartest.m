function [] = singleEartest()
%EDGE DETECTION:

%I=imread('s3.jpg');
%I = imread('test','*.jpg');
%I=rgb2gray(I);

%srcFiles = dir('C:\Users\Karthik Kikkuru\Documents\MATLAB\Pavan\test\*.jpg');
%Imgs = dir('C:\Users\Karthik Kikkuru\Documents\MATLAB\Pavan\test\*.jpg');
%NumImgs = size(Imgs,1);
%for i = 1:1:NumImgs
%for i = 1:1:length(srcFiles)
    
%I = strcat('C:\Users\Karthik Kikkuru\Documents\MATLAB\Pavan\test\',srcFiles(i).name);
%I = imread(I);




%D = dir('C:\Users\Karthik Kikkuru\Documents\MATLAB\EAR TEST\New folder\*.jpg');
D = dir('C:\Users\Karthik Kikkuru\Documents\MATLAB\EAR TEST\002_up_ear.jpg');
imcell = cell(1,numel(D));

count=0;

for i = 1:numel(D)
I = imread(D(i).name);


%sI = double(imread('C:\Users\Karthik Kikkuru\Documents\MATLAB\Pavan\test\',Imgs(1).name));

I=rgb2gray(I);


%I=imcrop(I,[104.5 114.5 304 486]);
%I=imcrop(I,[40.5 91.5 407 521]);
%I=imcrop(I,[17.5 51.5 469 630]);
%I=imcrop(I,[111.5 125.5 294 461]);
%I=imcrop(I,[9.5 46.5 467 639]);
%I=imcrop(I,[89.5 115.5 309 468]);
%background = imopen(I,strel('disk',15));



h=fspecial('gaussian',12 ,10);
%h=fspecial('disk',8);
final=imfilter(I,h);
%final=imfilter(final,h);
%final=imfilter(final,h);

%figure;imshow(final);
edgedetect=edge(final,'canny', [0.08,0.11]);
figure;imshow(edgedetect);
%impixelinfo

    
%CENTRE OF THE IMAGE:

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

d1=double(d1);d2=double(d2);d3=double(d3);d4=double(d4);

ratio= (d1/d2)*(d3/d4);
product = d1*d2*d3*d4;

disp(product);
oldRatios = csvread('test1.csv')

accessGranted = 0;
for j=oldRatios
    %if(product==j)
    %if(ratio==j)
    %if(ratio>=0.41 && ratio<=2.6)
    if abs(product - j) ==0
        ratio;
        product-j
      disp('Access granted');
        accessGranted = 1;
        
    count=count+1;
        %break;
    end
end

if accessGranted == 0
    disp('User not found!');
    ratio;
end

%figure;imshow(D(i).name)
%Value=ratio
end
%disp(product);
end
