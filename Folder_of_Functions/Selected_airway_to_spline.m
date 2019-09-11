function [centreline_spline_cell_phyiscal,corresponding_end_pts] = ...
    Selected_airway_to_spline( ...
    seg_image, dis_image, manual_points, raw_image, raw_sturct)
%This function converts the selected airway and all other proir infromation
%realted to the input of the function - Cubic_resampling_and_arclength
%I -
% seg_image - The segmentation tree
% dis_image - The dustance tranformation of the airway segmentation
% manual points - The points conatining the lablled terminal points
% raw_image - the image of interest
% raw_sturct - the header infromation inlc the raw image and voxel size
%O - centreline_spline_cell_phyiscal - the input of the for the function
%Cubic_resampling_and_arclength
%% Getting generating the start point
%Getting the start point
[~,start_point] = ...
    Mid_point_trachea_with_dis_image(dis_image);


%% Getting the end points from the manual label

index_end_points = find(manual_points);

%Defining the end points for the centreline
fixed_point = cat(1,start_point, index_end_points);
%Getting a pruning algorhtim
simple_point = struct;
simple_point.start_point = start_point;
simple_point.terminal_point = index_end_points;

%There is a possiable roundung problem - need to hole filler
seg_image = imfill(seg_image,'holes');

%Getting the centyreline image
centreline_image = Skeletonise_via_PTK_with_index(seg_image,fixed_point);

path_finder_sturct = struct;
path_finder_sturct.centreline_image = centreline_image;
path_finder_sturct.index_struct = simple_point;

%Getting the centreline path
[centreline_index_path_cell,corresponding_end_pts] = ...
    Centreline_path_extraction(path_finder_sturct);

%Need to extract remove the trachea - it will add another array to the cell
%struct
centreline_cell_without_trachea = ...
    Remove_trachea_from_path(centreline_index_path_cell);

%We will consider the point at the start of the first bifurcation
centreline_spline_cell_phyiscal = ...
    Consturct_centreline_spline_struct(centreline_cell_without_trachea,raw_image,...
    Voxel_size_information_from_struct(raw_sturct));

end

