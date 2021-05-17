%filter slice thickness

close all;
clear all;

cd 'D:\TCGA - LUAD\NIFTI'

mincc = 3;

addpath('C:\Users\Mitch\Documents\MATLAB\git\batchconvert');

all_files = dir;
all_files = all_files(~[all_files(:).isdir]);
num_files = numel(all_files);

for i = 1:num_files
    path = all_files(i).name; 
    info = niftiinfo(path);
    
    if info.PixelDimensions(3) > mincc
        movefile (path, 'D:\TCGA - LUAD\NIFTI\5mm\')
    end
end

