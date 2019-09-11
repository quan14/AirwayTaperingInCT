function coord_stuct = ...
    Grids_coords_for_plane( basis_1 , basis_2 , centre_point ,...
    length_of_plane , sampling_interval )
%Genrates that coorindates that we are requires to genreate the intensity

%The input are the 2 basis that span the plane, the sampling interval
%the size of the plane and the orgin point

%The Output will be stuct that contanins the x y z corrds of the plane

%% Getting the coeff

%Getting the coeffienct for the linear combination
ceoff_array = ...
    Construct_coeff_of_spanning_basis(sampling_interval,length_of_plane);

%Getting the basis
list_of_coords = ...
    Span_plane_points_from_basis(basis_1,basis_2,ceoff_array, ceoff_array,...
    centre_point);

%% Helping with the post-processing of data

x_coords = list_of_coords(1,:);
y_coords = list_of_coords(2,:);
z_coords = list_of_coords(3,:);

%% placing it into a struct

coord_stuct = struct;
coord_stuct.x = x_coords;
coord_stuct.y = y_coords;
coord_stuct.z = z_coords;

end

