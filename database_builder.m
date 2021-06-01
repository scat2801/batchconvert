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
%    not_found - IDs of files not found, can be passed as new index_mat in
%               another function call to search in a different folder.
%
% Examples: 
%    [not_found] = database_builder('C:\directory\', 'C:\database', index_mat)
%    
% Other m-files required: extractNumFromStr
% Subfunctions: none
% MAT-files required: none
%
% See also: mkdir_all.m, filename_retreiver

% Author: Mitchell Chen, BMBCh MEng DPhil FRCR 
% Email address: d.mitch.chen@gmail.com  
% May 2021; Last revision: 19-May-2021

%------------- BEGIN CODE --------------

not_found = index_mat;
not_found_op = zeros(length(not_found));

addpath 'C:\Users\Mitch\Documents\MATLAB\git\sort_files'

cd (folder_path);

all_files = dir;

all_files = all_files(~[all_files(:).isdir]);
num_files = numel(all_files);

mkdir (strcat(dist_path, '\duplicates'));

image_no = string(num_files);
size_mat = length(index_mat);

for j = 1:num_files
    image_no(j) = extractNumFromStr(all_files(j).name);
    
    for i = 1:size_mat
        try
        if index_mat(i) == image_no(j) 
            if isfile(strcat(dist_path, '\', all_files(j).name)) == 0
                copyfile (all_files(j).name, dist_path, 'f');
            else
                copyfile (all_files(j).name, strcat(dist_path, '\duplicates\'), 'f');
            end
            
            if not_found_op(i) == 0
                not_found(i) = [];
                not_found_op(i) = 1; 
            end
        end
        catch ME
            disp("Matrix index is out of range for deletion-2.");
        end
    end
end

%------------- END CODE --------------
