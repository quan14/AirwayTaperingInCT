function raw_image = RemoveBorder_adapted(expanded_image, border_size)
%% This is an adpeted function

%The input is the enlarge image and the border size

%The output is the raw image

% Removes a border of border_size voxels from the image in all dimensions

raw_image = expanded_image(1+border_size : end-border_size, 1+border_size : end-border_size, 1+border_size : end-border_size);

end