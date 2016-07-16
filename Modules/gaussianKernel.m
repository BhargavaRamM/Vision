function k = gaussianKernel(size,sd) 
k=zeros(size,size);
sum = 0;
for i=1:size 
    for j=1:size
        k(i,j) = (exp(-(i-size/2).^2+(j-size/2).^2/(2*sd.^2)))*1/(2*pi*sd*sd);
        sum = sum+k(i,j);
    end
end
for i=1:size
    for j=1:size
        k(i,j) = k(i,j)/sum;
    end
end
