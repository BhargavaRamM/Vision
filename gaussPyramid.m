function [Gauss] = gaussPyramid(I,n) 
[r,c,z] = size(I);
I=im2double(I);
sigma = 5;
sz = 7;
[x,y]=meshgrid(-sz:sz,-sz:sz);
p = size(x,1)-1;
q = size(y,1)-1;
kx = exp(-(x.^2)/(2*sigma*sigma))/(2*pi*sigma*sigma);
ky = exp(-(y.^2)/(2*sigma*sigma))/(2*pi*sigma*sigma);

%H = gaussianKernel(5,7);
%[p,q] = size(H);


%G=zeros(r,c,z);
%R = padarray(I,[sz sz]);
F=zeros(r,c,z);
for w = 1:z
    for i = 1:r
        for j = 1:c
            iValue = I(i,j,w).*kx;
            F(i,j,w) = sum(iValue(:));
        end
    end
end

for w = 1:z
    for i = 1:size(F,1)-p
        for j = 1:size(F,2)-q
            iValue = F(i:i+p,j:j+q,w).*ky;
            F(i,j,w) = sum(iValue(:));
        end
    end
end
F=cast(F,'like',I);
figure;imshow(F);


%{
for w=1:z  
    for i=1:r
      for j=1:c
        for k=1:p
          for l=1:q
           G(i,j,w)=G(i,j,w) + R(i+k-1,j+l-1,w).*H(k,l);
          end
        end
      end
    end
end
%}
%{
rf=pow2(n);
%rf = n;
%[a,s,z] = size(I);

a = r/rf;
s = c/rf;
R=Reduce(F);
%}
%G=zeros(a,s,z);
Gauss = cell(1,n+1);
Gauss{1} = I;
sample = F;
 for i = 2:n+1
     sample = Reduce(sample);
     Gauss{i} = sample;
 end
 celldisp(Gauss);
%{
for i=1:a
    for j=1:s
        for w=1:z
            G(i,j,w) = R(i*rf,j*rf,w);
        end
    end
end
    
%}

%G=cast(G,'like',I); 
%imshow(G);


end
        

