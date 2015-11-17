function [Laplace] = laplacePyramid(I,n) 
%[r,c,z] = size(I);
I = im2double(I);
g = gaussPyramid(I,n);
Laplace = cell(1,length(g));
%Laplace{1} = I;
%subsample = I;
%g = gaussPyramid(I,n+1);
for i = 1:length(g)-1
    subsample = Expand(g{i+1});
    rows = size(g{i},1);
    cols = size(g{i},2);
    subsample = subsample(1:rows,1:cols,:);
    Laplace{i} = g{i} - subsample;
    %{
    size(Laplace{i});
    size(g{i});
    size(Expand(g{i+1}));
    %}
end
Laplace{end} = g{end};
end