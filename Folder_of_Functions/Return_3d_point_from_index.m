function point_3d_vector = ...
    Return_3d_point_from_index( reference_image , list_of_index )
%This function returns a list of the 3d points for the coressponding index
%point

%The input is the reference image, to get the size. Also the list of
%indices to be converted

%The output is a list of the 3d point in matlab corrods.

%% Getting the 3d points

[x_point , y_point , z_point ] = ...
    ind2sub(size(reference_image),list_of_index(:));


%Combining the points together

point_3d_vector = [x_point, y_point, z_point];

end

