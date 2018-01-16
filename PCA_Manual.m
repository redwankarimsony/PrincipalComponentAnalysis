%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%													%
%													%
%	Principal Component Analysis Implementation		%
%													%
%	Md. Redwan Karim Sony,							%
%	Student ID: 124401,								%
%	Department of CSE,								%
%	Islamic University of Technology(IUT)			%
%	Gazipur, Dhaka									%
%													%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%









clear; clc; close all ; %clearing all the previous information from the stack
%Number of images present in the test set
imageNum = 200; 
%Size of the individual image. Here images are in square proportion. 
dim = 50;
%Number of eigen values selected finally
NoOfEigenValues = 100;

X = zeros(imageNum, dim * dim);

% Arrange each image as a vector.
for i=1:imageNum
    face1 = imageRead(i, dim);
    X(i, :) = face1;
end

%Calculating the mean of the dataset X 
Xmew = X ;
Xmean = mean(X);
%subtracting the mean from each of the images in dataset X. 
%Mean subtracted data is Xmew
for i = 1:imageNum
    Xmew(i,:) = X(i, :) - Xmean;
end

%Calculating the Covariance Matrix
covarianceMatrix = cov(Xmew); 
%Calculating the eigenvalue and eigenvector from covariance Matrix. 
[COEFF, latent] = eig (covarianceMatrix);

%	latent 	= eigenvalues in a vector. Remember latent is a diagonal matrix. 
%	COEFF 	= eigenvectors. each column represents one eigenvector. 

%%sorting the eigenvalues and eigenvectors

[CC, LL] = sortem(COEFF, latent); 
%      AFTER SORTING
%	LL  	= sorted eigenvalues in a vector
%	CC 	= sorted eigenvectors according to the sorted eigenvectors. each column represents one eigenvector. 

temp = zeros(1, dim*dim);
for k = 1:dim*dim
    temp(1,k) = LL(k ,k);
end

latent = temp';
COEFF = CC; 


% Histogram plot to see the eigenvalues' comparison in a graph plot. 
figure; stem(latent); 



selectedEigenValues = latent (1:NoOfEigenValues, :);
figure; bar(selectedEigenValues); 
selectedEigenVectors = COEFF(: , 1:NoOfEigenValues); 

%constructing the new transforming matrix from here

%calculating the feature vector
features = Xmew * selectedEigenVectors; 
figure; 

 psnrValues = zeros(1, imageNum);

 
  
%% Reconstruction and PSNR Calculations


% It will plot the original and reconstructed face from the new feature space 
% Try to understand the difference between original and reconstructed image.
% You might want to change the value imageNum in order to reduce runtime.

for aa = 1:imageNum 
    image1 = features(aa,:) * selectedEigenVectors';
    image1 = image1 + Xmean;
	%reconstructed image from the new feature space. 
    outputImageRecon = image1;
    
    %Original Image
    outputImageOrg = zeros(dim, dim);
    outputImageOrg = X(aa, :);  
    
    % PSNR CALCULATIONS
    psnrValues(1, aa) = PSNR(outputImageOrg, outputImageRecon, dim);
    
    
    
  
   figure; 
     subplot(1,2,1);  imshow(array2img(outputImageOrg, dim), []); title('Original Image');
     subplot(1,2,2); imshow(array2img(outputImageRecon, dim), []);title('Reconstructed Image');
end


disp('PSNR Values');
psnrValues


disp('Average PSNR');
mean(mean(psnrValues))





