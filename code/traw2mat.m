% Load the genotype matrix stored in a text file, and save it in a format 
% that is more convenient for loading into MATLAB.

% SCRIPT PARAMETERS
% -----------------
% This is a .fam file 
famfile = '/tmp/pcarbo/1kg.fam';

% This is a .traw file storing the genotype data. For details on this
% file format, see http://www.cog-genomics.org/plink2/formats#traw.
genofile = '/tmp/pcarbo/1kg.traw';

% Save the genotype data to this MATLAB binary file.
outfile = '/tmp/pcarbo/1kg.mat';

% Number of genotyped samples.
n = 2289;

% Number of genotyped SNPs.
p = 655388;

% READ SAMPLE INFORMATION
% -----------------------
fprintf('Reading sample information.\n');
f      = fopen(famfile,'r');
format = '%s %s %f %f %f %f';
data   = textscan(f,format);
id     = data{1};
fclose(f);

% READ GENOTYPE MATRIX
% --------------------
% We deal with the small number of missing genotypes in an ad hoc way by
% populating the missing entries with the mean genotype value.
fprintf('Reading genotype matrix from .traw file.\n');
marker = cell(p,1);
X      = zeros(n,p);
f      = fopen(genofile,'r');
format = repmat('%s ',1,n + 6);
fgetl(f);
for i = 1:p
  fprintf('line #%06d ',i);
  fprintf(repmat('\b',1,13));
  data      = textscan(f,format,1,'Delimiter',' ');
  marker{i} = data{2};
  data      = [data{6 + (1:n)}];

  % Populate the genotype data for the ith marker.
  X(:,i) = -1;
  X(find(strcmp(data,'0')),i) = 0;
  X(find(strcmp(data,'1')),i) = 1;
  X(find(strcmp(data,'2')),i) = 2;

  % Populate the missing genotypes by the mean genotype value.
  j      = strcmp(data,'NA');
  X(j,i) = mean(X(~j,i));
end
fprintf('\n');
fclose(f);

% SAVE GENOTYPE MATRIX
% --------------------
fprintf('Saving genotype matrix to .mat file.\n');
save(outfile,'id','marker','X','-v7.3');
