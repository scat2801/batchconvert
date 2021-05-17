%filter slice thickness

close all;
clear all;

folderpath = 'D:\IO Cohorts\CPTAC-LUAD\manifest-1621170891678\NIFTI'
cd (folderpath)

mincc = 3;

addpath('C:\Users\Mitch\Documents\MATLAB\git\batchconvert');

mkdir (strcat(folderpath, '\5mm'));

all_files = dir;
all_files = all_files(~[all_files(:).isdir]);
num_files = numel(all_files);

for i = 1:num_files
    path = all_files(i).name; 
    info = niftiinfo(path);
    
    all_files(i).cc = info.PixelDimensions(3);
    all_files(i).ax1 = info.PixelDimensions(1);
    all_files(i).ax2 = info.PixelDimensions(2);
    
    if info.PixelDimensions(3) > mincc
        movefile (path, strcat(folderpath, '\5mm'));
    end
end

