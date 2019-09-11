function index_of_neigbours  = ...
    Neigbour_pts_26_points_index_output( index_points , binary_image )
%This fucntion gives a list of index that are in the 26 neibourhood voxel -
%note that the function can cope with multple points

%The input is the list of index points in array form and the binary image

%The output is the list of index form the neibouourhood

%% Convert the index into subsricpts

[x_com,y_com,z_com] = ind2sub(size(binary_image),index_points);

list_of_points = [x_com,y_com,z_com];

%% Use the function we already have!!!

list_of_neigh_points = Neigbourhood_points_assuming_26_points(list_of_points,binary_image);

%% Covert them back into index

index_of_neigbours = sub2ind(size(binary_image),list_of_neigh_points(:,1),list_of_neigh_points(:,2),list_of_neigh_points(:,3));

end

