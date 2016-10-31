% TO DO: Explain here what this script does.

% SCRIPT PARAMETERS
% -----------------
% This is a .fam file 
famfile = '/project/rcc/workshops/genetic-data-analysis-1/1kg.fam';

% This is a .traw file storing the genotype data. For details on this
% file format, see http://www.cog-genomics.org/plink2/formats#traw.
genofile = '/project/rcc/workshops/genetic-data-analysis-1/1kg_chr22.traw';

% Save the genotype data to this MATLAB binary file.
outfile = '../data/1kg.mat';

% Number of genotyped samples.
n = 2289;

% Number of genotyped SNPs.
p = 9559;

% READ SAMPLE INFORMATION
% -----------------------
fprintf('Reading sample information.\n');
f      = fopen(famfile,'r');
format = '%s %s %f %f %f %f';
data   = textscan(f,format);
id     = data{1};
fclose(f);

% READ GENOTYPE DATA
% ------------------
fprintf('Reading genotype data from .traw file.\n');
marker = cell(p,1);
X      = zeros(n,p);
f      = fopen(genofile,'r');
format = repmat('%s ',1,n + 6);
fgetl(f)
for i = 1:p
  fprintf('line #%6d ',i);
  fprintf(repmat('\b',1,13));
  data      = textscan(f,format,1,'Delimiter',' ');
  marker{i} = data{2};
  
end
fprintf('\n');
fclose(f);

fprintf('Saving genotype and phenotype data.\n');
save(outfile,'X');
