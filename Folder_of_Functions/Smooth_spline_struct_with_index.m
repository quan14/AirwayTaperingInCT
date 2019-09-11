function smooth_spline_struct = ...
    Smooth_spline_struct_with_index(reference_image, list_of_ordered_indices,voxel_size )
%Computes a smooth spline sturct for tappering

%The input is the list of ordered index

%The output is the smooth spline as a matlab sturct

%% Convert into 3d Points

list_of_ordered_point = ...
    Return_3d_point_from_index(reference_image,list_of_ordered_indices);

%% Smoothing the data points

%Smoothing the data
smooth_x = smooth(list_of_ordered_point(:,1)*voxel_size(1));
smooth_y = smooth(list_of_ordered_point(:,2)*voxel_size(2));
smooth_z = smooth(list_of_ordered_point(:,3)*voxel_size(3));

%Complete smooth data
smooth_data_points = [smooth_x smooth_y smooth_z]';

%Generating the spline 
smooth_spline_struct = cscvn(smooth_data_points);

end

