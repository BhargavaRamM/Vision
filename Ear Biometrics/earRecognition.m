function [out] = earRecognition(input,path)
D = dir(path);
imgcount = 0;
for i=1 : size(D,1)
    if not(strcmp(D(i).name,'.')|strcmp(D(i).name,'..')|strcmp(D(i).name,'Thumbs.db'))
        imgcount = imgcount + 1; % Number of all images in the training database
    end
end

X = [];
for i = 1:imgcount
	str = strcat(path,'\',int2str(i),'.jpg');
	img = imread(str);
	if size(img,3) == 3
		img = rgb2gray(img);
	end
	[r,c] = size(img);
	temp = resize(img',r*c,1);
	X = [X temp];
end
m = mean(X,2);
imgcount = size(X,2);

A = [];
for i = 1:imgcount
	temp = double(X(:,i))-m;
	A = [A temp];
end
cov = A*A';
[v,d] = eig(cov);

cov_eigen_vector = [];
for i = 1:size(v,2)
	if (d(i,i)>1)
		cov_eigen_vector = [cov_eigen_vector v(:,i)];
	end
end	
eigenEars = A*cov_eigen_vector;
projectionE = [];
for i = 1:size(eigenEars,2)
	temp = eigenEars'*A(:,i);
	projectionE = [projectionE temp];
end


ip = imread(input);
ip = ip(:,:,1);
[p q] = size(ip);
tmp = reshape(ip',p*p,1);
tmp = double(tmp)-m;
projectionIp = eigenEars'*tmp;

%euclid_distance = 0
euclid_distance = [ ];
for i=1 : size(eigenEars,2)
    temp = (norm(projectionIp-projectionE(:,i)))^2;
    euclid_distance = [euclide_dist temp];
end
[euclid_distance_min recognized_index] = min(euclid_distance);
recognized_img = strcat(int2str(recognized_index),'.jpg');
out = recognized_img;
end
