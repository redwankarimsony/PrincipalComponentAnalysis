function [out] = imageRead(index, dim)
% Use loop as necessay
i= index;
filepre='imageset/img_';

s=num2str(i); % i is the image number.

impath=strcat(filepre,s,'.jpg');
input = imread(impath);

% Resize Image as necessary.
input = imresize(input, [dim,dim]);

% Convert to grayscale image.
input = rgb2gray(input);
 %figure; imshow(input);
out = zeros(1, dim * dim);
out = uint8(out);
k = 1;
for a = 1:  dim
    for b = 1: dim
        out(1,k) = input(a, b);
        k = k +1;
    end
end





