%one file conversion from unzip to nifti. Start in source directory

close all;
clear all;

cd 'D:\LCconvert\unzip'
%cd 'C:\Users\mchen\Downloads\LCconvert\unzip'

addpath('C:\Users\Mitch\Documents\MATLAB\git\dicm2nii');
addpath('C:\Users\Mitch\Documents\MATLAB\git\batchconvert');

% addpath('C:\Users\mchen\Documents\MATLAB\dicm2nii');
% addpath('C:\Users\mchen\Documents\MATLAB\dcnconvert');

all_files = dir;
%all_dir = all_files([all_files(:).isdir]);
num_dir = numel(all_files) - 2;

path = string(num_dir);
image_no = string(num_dir);

%choose source folder
for i = 1:num_dir
%DICOM files folder
    path (i) = strcat(all_files(i+2).folder, '\', all_files(i+2).name);
    image_no (i) = all_files(i+2).name;
end

%dest_path
save_path = 'D:\LCconvert\output';
%save_path = 'C:\Users\mchen\Downloads\LCconvert\output';
% mydir = dest_path;

% idcs   = strfind(mydir,'\');
% save_path = mydir(1:idcs(end)-1);
% save_path = strcat(save_path,'\output');

% f = waitbar(0,'1','Name','Running',...
%     'CreateCancelBtn','setappdata(gcbf,''canceling'',1)');
% 
% setappdata(f,'canceling',0);

%convert to nii
for i = 1:num_dir
    
%     if getappdata(f,'canceling')
%         break
%     end
%     
    %target_file_name set-up
    
    target_file_name = strcat(image_no(i), '.nii.gz');
    
    dicm2nii_filtered(path(i), save_path, 'nii.gz');
    mat_file = strcat(save_path, '\', 'dcmHeaders.mat');
    
    load (mat_file);
    names =  fieldnames(h);
    delete_extra = '';
    
    %if all 512, then keep the one with most number of CC slices
    op_slices = 0;
    op_index = 1;
    op_counter = 0;
    
    if size(names,1) > 1
        for j = 1:size(names,1)
            tmp_field = getfield(h,names{j});
            if isfield(tmp_field, 'Rows') & isfield(tmp_field, 'Columns')
                if tmp_field.Rows == 512 & tmp_field.Columns == 512
                    op_counter = op_counter + 1;
                end
            end
        end
    end
    
    if op_counter > 1
        for j = 1:size(names,1)
            if isfield (getfield(h,names{j}), 'LocationsInAcquisition')
                if getfield(h,names{j}).LocationsInAcquisition > op_slices & getfield(h,names{j}).Rows == 512 & getfield(h,names{j}).Columns == 512
                    op_slices = getfield(h,names{j}).LocationsInAcquisition;
                    op_index = j;
                end
            end
        end

        for j = 1:size(names,1)
            if j ~= op_index
                 extra = string(strcat(save_path, '\', names(j), '.nii.gz'));
                 delete (extra)
            end
        end
    end
%         for j = 1:size(names,1)
%             if isfield (getfield(h,names{j}), 'Rows')
%                 if getfield(h,names{j}).Rows ~= 512 | getfield(h,names{j}).Columns ~= 512
%                     extra = string(strcat(save_path, '\', names(j), '.nii.gz'));
%                     delete (extra)
%                 end
%             else
%             extra = string(strcat(save_path, '\', names(j), '.nii.gz'));
%                     delete (extra)
%             end
%         end
        

    
    
    delete (mat_file)

    %needs name changing
    latest_file = strcat(save_path, '\', getlatestfile(save_path));
    target_file = strcat(save_path, '\', target_file_name);
    movefile (latest_file, target_file)
%     
%     waitbar(i/num_dir,f,sprintf('p.'))
    
end

% delete(f)