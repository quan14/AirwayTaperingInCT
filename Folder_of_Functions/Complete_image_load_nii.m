function [ image_struct , image_matrix , image_path ] = ...
    Complete_image_load_nii( image_path )
%Returns the struct, matrix and the image path - this function has been
%modifed to cope with seg_em images

%The input the is the image path, matrx and the struct. Note the matrix
%will always be in double

%The output is the struct , matrix and path name.

%% Using the nii toolbox

image_struct = load_untouch_nii(image_path);

%Getting the matrix
image_matrix = double(image_struct.img);

if ndims(image_matrix) == 4
    
    image_matrix = image_matrix(:,:,:,1);
    
end


end

