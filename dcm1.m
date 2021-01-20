%convert from DICOM to nifti

close all;
clear all;

addpath('C:\Users\mchen\Documents\MATLAB\dicm2nii');

%DICOM files folder
[path] = uigetdir('C:\Users\mchen\Downloads\',...
    'choose DICOM files folder');

image_no = extractAfter(path,'E:\convert_dir\');
image_no = extractBefore(image_no, '\');

image_no = strcat(image_no, 'nii.gz');

mydir = path;

idcs   = strfind(mydir,'\');
save_path = mydir(1:idcs(end)-1);
save_path = strcat(save_path,'\output');
 
dicm2nii(path, save_path, 'nii.gz');
to_del = strcat(save_path, '\', getlatestfile(save_path));
delete (to_del)

latest_file = strcat(save_path, '\', getlatestfile(save_path));
target_file = strcat(save_path, '\', image_no);
movefile (latest_file, target_file)