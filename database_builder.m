function [not_found] = database_builder(folder_path, dist_path, index_mat)
%database_builder - retreives files from the lung cancer cohort using an 
% filenames index (numerical). All image types will be considered.
%database will be built at the directory specified by dist_folder
% Syntax:  [all_files, image_no] = filename_retriever(folder_path, type)
%
% Inputs:
%    folder_path - directory path
%    index_mat - array of numerical scan IDs
%
% Outputs:
%    not_found - IDs of files not found, can be passed as index_mat in
%               another function call to search in a different folder.
%
% Examples: 
%    [not_found] = database_builder('C:\directory\', 'C:\database', index_mat)
%   
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% See also: mkdir_all.m, filename_retreiver

% Author: Mitchell Chen, BMBCh MEng DPhil FRCR 
% Email address: d.mitch.chen@gmail.com  
% May 2021; Last revision: 19-May-2021

%------------- BEGIN CODE --------------

not_found = index_mat;

cd (folder_path);

all_files = dir;

all_files = all_files(~[all_files(:).isdir]);
num_files = numel(all_files);

image_no = string(num_files);

for j = 1:num_files
    if all_files(j).name(end) == 'i'
        image_no(j) = extractBefore(all_files(j).name, '.nii');
    elseif all_files(j).name(end) == 'z'
        image_no(j) = extractBefore(all_files(j).name, '.nii.gz');
    elseif all_files(j).name(end) == 'd'
        image_no(j) = extractBefore(all_files(j).name, '.nrrd');
    end
    
    size_mat = length(not_found);
    
    for i = 1:size_mat
        try
        if not_found(i) == image_no(j) 
            copyfile (all_files(j).name, dist_path,'f');
            try
                not_found(i) = [];
            catch ME
                disp("Matrix index is out of range for deletion.");
            end
            break;
        end
        catch ME
            disp("Matrix index is out of range for deletion.");
        end
    end
end

%------------- END CODE --------------
