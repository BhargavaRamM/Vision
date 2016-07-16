function [Recon] = Reconstruct(LI,n)
%celldisp(LI);
laplace = LI;
%lap_length = n+1;
for i = length(LI): -1 : 2
    
    subsample = Expand(laplace{i});
    rows = size(laplace{i-1},1);
    cols = size(laplace{i-1},2);
    subsample = subsample(1:rows,1:cols,:);
    laplace{i-1} = laplace{i-1} + subsample;
end

Recon = laplace{1};

end


