function [out] = PSNR(img1, img2, dim)

difference = abs(img1 - img2);

square = difference.* difference;
MSE = sum(sum(square))/(dim*dim);
MAX = max(max(img1));
out =  20 * log10(MAX) - 10*log10(MSE);





