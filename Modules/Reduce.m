function R = Reduce(I) 
[r,c,z] = size(I);
out_rows = floor(r/2);
out_cols = floor(c/2);
% Bi-Linear Interpolation of Image

sr = r/out_rows;
sc = c/out_cols;

[cf,rf] = meshgrid(1:out_cols,1:out_rows);
rf=rf*sr;
cf=cf*sc;

r_new = floor(rf);
c_new = floor(cf);

r_new(r_new<1) = 1;
c_new(c_new<1) = 1;
r_new(r_new>r-1) = r-1;
c_new(c_new>c-1) = c-1;


dr=rf-r_new;
dc=cf-c_new;

id1 = sub2ind(size(I),r_new,c_new);
id2 = sub2ind([r,c],r_new+1,c_new);
id3 = sub2ind(size(I),r_new,c_new+1);
id4 = sub2ind(size(I),r_new+1,c_new+1);

R = zeros(out_rows,out_cols,z);
R=cast(R,'like',I);

for w = 1:z
    chan = double(I(:,:,w));
    red = chan(id1).*(1-dr).*(1-dc) + chan(id2).*dr.*(1-dc) + chan(id3).*(1-dr).*dc + chan(id4).*dr.*dc;
    R(:,:,w) = cast(red,'like',I);
end
%imshow(R);
end   
