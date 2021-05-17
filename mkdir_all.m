%mkdir
%start in target directory

close all;
clear all;

cd 'F:\NII 300421\Satisfactory';

% cd 'C:\Users\mchen\Downloads\LCconvert\to convert\';

all_files = dir;
num_files = numel(all_files)-2;

path = string(num_files);

for i = 1:num_files
    path(i) = all_files(i+2).name; 
    
    %image_no(i) = extractBefore(path(i), '.zip');
   
    image_no(i) = extractBefore(path(i), '.nii.gz');
    
    cd 'D:\LCconvert\unzip\';
    
    mkdir(image_no(i));
    
    cd 'F:\DCM 30042021';

end
