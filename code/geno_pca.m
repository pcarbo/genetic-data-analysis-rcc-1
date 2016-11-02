% Compute the top k principal components of n x p genotype matrix X,
% where n is the number of samples and p is the number of genetic markers 
% (SNPs). 

% SCRIPT PARAMETERS
% -----------------
% This is the number of PCs to compute.
k = 10; 

% This is the MATLAB binary file storing the genotype matrix.
genofile = '../data/1kg_train.mat';

% Save the rotation matrix to this text file.
rotfile = '../results/1kg_train_rot.txt';

% Save the PCs to this text file.
pcfile = '../results/1kg_train_pcs.txt';

% Save the mean genotypes to this text file.
meanfile = '../results/1kg_train_mean.txt';

% LOAD GENOTYPE MATRIX
% --------------------
fprintf('(1) Loading genotype matrix from .mat file.\n');
load(genofile);
[n p] = size(X);
fprintf('Loaded a %d x %d matrix.\n',n,p);

% CENTER GENOTYPE MATRIX COLUMNS
% ------------------------------
% Center the columns of the genotype matrix so that each column has a
% mean of zero.
fprintf('(2) Centering columns of genotype matrix.\n');
y = zeros(p,1);
for i = 1:p
  y(i)   = mean(X(:,i));
  X(:,i) = X(:,i) - y(i);
end

% COMPUTE PCs USING SVDK
% ----------------------
tic;
fprintf('(3) Calculating first %d PCs.\n',k);
[U S R] = svdk(X,k);
fprintf('Computation took %0.2f minutes.\n',toc/60);

% SAVE ROTATION MATRIX TO TEXT FILE
% ---------------------------------
% We save the rotation matrix to a space-delimited text file so that it
% is easily loaded into R.
fprintf('(4) Saving rotation matrix to text file.\n');
write_rot_matrix(R,marker,rotfile);

% Project the samples onto the PCs. Note that this is equal to U * S
% from the singular value decomposition.
fprintf('(5) Projecting samples onto the principal components.\n');
pc = X * R;

% SAVE PCs TO TEXT FILE
% ---------------------
% We save the computed PCs to a space-delimited text file so that they
% are easily loaded into R.
fprintf('(6) Saving PCs to text file.\n');
write_pc_matrix(pc,id,pcfile);

% SAVE MEAN GENOTYPES TO TEXT FILE
% --------------------------------
% It is also important that we save the mean genotypes since they will be
% useful later on.
fprintf('(7) Saving mean genotypes to text file.\n');
write_mean_genotypes(y,marker,meanfile);
