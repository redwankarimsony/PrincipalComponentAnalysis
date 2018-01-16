function [ output ] = array2img( array, dim )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

output = zeros(dim, dim);
count =0;
for i =1:dim
    for j=1:dim
        count = count +1;
        output(i,j) = array(count);
    end
end


end

