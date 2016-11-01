% TO DO: Explain here what this script does.

% SCRIPT PARAMETERS
% -----------------
% This is the number of PCs to compute.
k = 10; 

% This is the MATLAB binary file storing the genotype matrix.
genofile = '/tmp/pcarbo/1kg_train.mat';

% Save the rotation matrix to this text file.
outfile = '../results/1kg_train_rot.txt';

% Save the PCs to this text file.
outfile = '../results/1kg_train_pcs.txt';

% LOAD GENOTYPE MATRIX
% --------------------
fprintf('Loading genotype matrix from .mat file.\n');
[n p] = size(X);

% CENTER COLUMNS
% --------------
% Center the columns of the genotype matrix so that each column has a
% mean of zero.
fprintf('Centering columns of genotype matrix.\n');
for i = 1:p
  X(:,i) = X(:,i) - mean(X(:,i));
end

% COMPUTE PCs USING SVDK
% ----------------------
fprintf('Calculating first %d PCs.\n',k);
[U S R] = svdk(X,k);

% SAVE ROTATION MATRIX TO TEXT FILE
% ---------------------------------
% We save the rotation matrix to a space-delimited text file so that it
% is easily loaded into R.
fprintf('Saving rotation matrix to text file.\n');
% TO DO.

% Project the samples onto the PCs.
%
% NOTE: Is this necessary? I don't think it is.
%
pc = X * R;

% SAVE PCs TO TEXT FILE
% ---------------------
% We save the computed PCs to a space-delimited text file so that they
% are easily loaded into R.
fprintf('Saving PCs to text file.\n');
% TO DO.