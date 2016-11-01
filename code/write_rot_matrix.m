% Write the rotation matrix R to a space-delimited text file. This
% function is used in MATLAB script geno_pca.m.
function write_rot_matrix (file, R, id, marker)

  [p k] = size(R);
f = fopen('~/Desktop/celiac_pc.csv','w');
fprintf(f,'id');
fprintf(f,',PC%d',1:10);
fprintf(f,'\n');
for i = 1:n
  fprintf(f,'%s',id{i});
  fprintf(f,',%0.4f',pc(i,:));
  fprintf(f,'\n');
end
fclose(f);
