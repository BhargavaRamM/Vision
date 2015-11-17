function E = Expand(I) 
[r,c,z] = size(I);
%figure;imshow(I);
%if (mod(2*r+1,2) == 1 && mod(r+1,2) == 0)

r1 = size(Reduce(I),1);

if (r-2*r1 == 0 && mod(r,2) == 0)
    r_out = 2*r;
    c_out = 2*c;
    else
    if(r-2*r1 == 0 && mod(r1,2) == 1) 
    r_out = 2*r+1;
    c_out = 2*c+1;
    else
        if(r-2*r1 == 1 && mod(r,2)== 1 && mod(r1,2)==1)
    r_out = 2*r;
    c_out = 2*c;
    else 
        r_out = 2*r+1;
        c_out = 2*c+1;
       
        end
    end
end
%{
   else 
    r_out = 2*r+1;
    c_out = 2*c+1;
end
    %}

    sr = r/r_out;
    sc = c/c_out;

[cf,rf] = meshgrid(1:c_out,1:r_out);
rf = rf*sr;
cf = cf*sc;
r_new = floor(rf);
c_new = floor(cf);

r_new(r_new<1) = 1;
c_new(c_new<1) = 1;
r_new(r_new > r-1) = r-1;
c_new(c_new > c-1) = c-1;


dr=rf-r_new;
dc=cf-c_new;

id1 = sub2ind(size(I),r_new,c_new);
id2 = sub2ind([r,c],r_new+1,c_new);
id3 = sub2ind(size(I),r_new,c_new+1);
id4 = sub2ind(size(I),r_new+1,c_new+1);

E = zeros(r_out,c_out,z);
E=cast(E,'like',I);

for w = 1:z
    chan = double(I(:,:,w));
    red = chan(id1).*(1-dr).*(1-dc) + chan(id2).*dr.*(1-dc) + chan(id3).*(1-dr).*dc + chan(id4).*dr.*dc;
    E(:,:,w) = cast(red,'like',I);
end
%subplot(1,2,1);imagesc(I);
%subplot(1,2,2);imagesc(E);
figure;imshow(E);

