close all;
clear all;

%replace this with the folder directory containing satisfactory scans
cd 'D:\uploaded - 261020';

all_files = dir;
num_files = numel(all_files)-2;

path = string(num_files);

for i = 1:num_files
    path(i) = all_files(i+2).name; 
    image_no(i) = extractBefore(path(i), '.nii');
    disp(image_no(i))
end



