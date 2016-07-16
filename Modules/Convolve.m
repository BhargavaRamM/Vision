function y = Convolve(I,H)
[m,n,o]=size(I);
%classI = class(I);
I=im2double(I);
y=zeros(m,n,o);
[p,q]=size(H);
% my = max([m+p-1,m,p]);
 %ny =  max([n+q-1,n,q]);
% size(y)=[my ny 3]
%y=zeros(m + p*2-2, n + q*2-2);
%imshow(y);
%for w=1:o 
p1 = floor(p/2);
q1 = floor(q/2);
R=padarray(I,[p1 q1]);
%end


%R2=im2double(R);
%H2=im2double(H);
%{
Rep = zeros(m + p*2-2, n + q*2-2);
for x = p : m+p-1
    for y = q : n+q-1
        Rep(x,y) = I(x-p+1, y-q+1);
    end
end 
%}

  for w=1:o  
    for i=1:m
      for j=1:n
        for k=1:p
          for l=1:q
           y(i,j,w)=y(i,j,w) + R(i+k-1,j+l-1,w).*H(k,l);
          end
        end
      end
    end
  end

%{
for i=1:m
    for j=1:m
       y(i,j)=dot(R2(i,j),H2,3);
    end
end
  %}
%colormap(I);  
%stem(y);
y=cast(y,'like',I);
%subplot(1,2,1); imagesc(I);
%subplot(1,2,2); imagesc(y);
%pause
%y=uint8(y);
imshow(y);
