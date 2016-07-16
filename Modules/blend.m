function fun = blend(I,J,n) %py_i,py_j,py_m are image pyramids crea
 red1 = I(:,:,1);
 green1 = I(:,:,2);
 blue1 = I(:,:,3);
 red2 = J(:,:,1);
 green2 = J(:,:,2);
 blue2 = J(:,:,3);
 
 

 ri = roipoly(red1);
 rj = roipoly(red2);
 
 gi = roipoly(green1);
 gj = roipoly(green2);
 
 bi = roipoly(blue1);
 bj = roipoly(blue2);
 
 M(:,:,1) = ri;
 M(:,:,2) = gi;
 M(:,:,3) = bi;
 
 N(:,:,1) = rj;
 N(:,:,2) = gj;
 N(:,:,3) = bj;
 
 py_i = laplacePyramid(I,n);
 py_j = laplacePyramid(J,n);
 mask_i = gaussPyramid(M,n);
 mask_j = gaussPyramid(N,n);
 
 fun = cell(1,length(py_i));
 
   for i = 1: length(py_i)
      img_i = py_i{i};
      img_j = py_j{i};
      img_Bi = mask_i{i};
      img_Bj = mask_j{i};
      %[r1,c1] = size(img_i);
     % [r2,c2] = size(img_Bi);
      
      if (size(img_Bi,1) >= size(img_Bj,1));
         mask = img_Bi;
      else 
          mask = img_Bj;
      end
      %img_i = rgb2gray(img_i);
      %img_j = rgb2gray(img_j);
      fun{i} = (1-mask) .* img_i + mask .* img_j;
   end
  % map = colormap(py_i{i});
   fun = Reconstruct(fun,length(fun)-1);
   %fun = colormap(map);
 end
