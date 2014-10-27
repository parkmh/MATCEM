% For more information, see <a href="matlab: 
% web('http://www.grandmaster.colorado.edu/~parkmh')">Minho Park's Web site</a>.
cd bin
Ver = cemversion;
user = 'Minho Park';
email = 'min.park@nottingham.ac.uk';
cd ..

clc
fprintf(' ********************************************\n')
fprintf('\n')
fprintf(' Matlab Circulant Embedding Toolbox  %s \n',Ver) 
fprintf('\n')
fprintf('%20s %s\n','Written by', user);
fprintf('%13s %s\n','email :',email);
fprintf(' ********************************************\n')


cwd = pwd;
matcemroot = pwd;

% Add path
% Generate amgpath.m file
fid = fopen([pwd filesep 'bin' filesep 'cempath.m'],'w');
fprintf(fid,'function matcempath = cempath\n');

fprintf('\n1. Add path\n%s\n',matcemroot)

addpath(fullfile(matcemroot,'bin'));
fprintf(fid,'matcempath = ''%s'';\n',matcemroot);

fclose(fid);
savepath


% Compile mex files
cd(fullfile(cwd,'src'));
copyfile('*.c',fullfile(cwd,'bin'))

cd(fullfile(cwd,'bin'));
fprintf('\n2. Compile mex -O Files\n')
cd([cwd filesep 'bin'])

try
    fprintf('Compiling computeFirstColumn2D.c\n')
    mex -O first_column2d_mex.c
    fprintf('Compiling computeR12k2D.c\n');
    mex -O compute_R12k_2d_mex.c
    fprintf('Compiling computeR122D_mex.c\n');
    mex -O compute_R12_2d_mex.c
    
catch err
    cd ..
    error('mex -O compile error')
end
clear all

