function [all_files, image_no] = filename_retriever(folder_path, type)
%filename_retriever - retreives folder or filenames in a given folder
%
% Syntax:  [all_files, image_no] = filename_retriever(folder_path, type)
%
% Inputs:
%    folder_path - directory path
%    type - type of file, if left blank, folder names are returned
%
% Outputs:
%    all_files - files matrix
%    image_no - file names array
%
% Examples: 
%    1. [all_files, image_no] = filename_retriever('C:\directory\', '.nii.gz')
%    2. [all_files, image_no] = filename_retriever('C:\directory\')
%    3. [all_files] = filename_retriever('C:\directory\')
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% See also: batchconvert.m, mkdir_all.m

% Author: Mitchell Chen, BMBCh MEng DPhil FRCR 
% Email address: d.mitch.chen@gmail.com  
% May 2021; Last revision: 18-May-2021

%------------- BEGIN CODE --------------

cd (folder_path);

all_files = dir;

%If folder option
if nargin == 1 
    all_files = all_files([all_files(:).isdir]);
elseif nargin == 2
    all_files = all_files(~[all_files(:).isdir]);
else 
    disp('re-check number of inputs');
    return;
end

num_files = numel(all_files);

image_no = string(num_files);

for i = 1:num_files
    if nargin == 1
        image_no(i) = all_files(i).name;
    elseif nargin == 2
        image_no(i) = extractBefore(all_files(i).name, type);
    else
        disp('re-check number of inputs');
        return;
    end
end

image_no = image_no';
%------------- END CODE --------------
