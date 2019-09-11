function plane_intensities = ...
    Plan_intensities_via_matlab_interpol( voxel_size,raw_image,...
    points_struct )
%This function returns the plane intensities form the given points - the
%intensties are given in cubic interpolation. We assume that the plane is a
%sqaure shape.

%The input is the voxel size vector in the from of [x y z], raw image that
%we will be interpolating. and the points that on the plane. Note the the
%points_sturct comes from Grids_coords_for_plane
% coord_stuct = struct;
% coord_stuct.x = x_coords;
% coord_stuct.y = y_coords;
% coord_stuct.z = z_coords;

%The output is the plane of intensiteis that has been reshape.

%% Getting the grid made

size_of_image = size(raw_image);
%NOTE HOW THE POINTS ARE ARRANGED IN THIS FUNCTION !!!!!
[x_domain , y_domain , z_domain] = ...
    meshgrid(1:size_of_image(2),1:size_of_image(1),1:size_of_image(3));

%Taking into account the voxel size
x_domain = x_domain*voxel_size(1);
y_domain = y_domain*voxel_size(2);
z_domain = z_domain*voxel_size(3);

%% Perfroming the interpolation

%We will us the cubic inperpolation

%NOTE HOW THE POINTS ARE ARRANGED IN THIS FUNCTION !!!!!
plane_intensities = interp3(x_domain,y_domain,z_domain,...
    raw_image,points_struct.y(:),points_struct.x(:),...
    points_struct.z(:),'cubic');

%Reshape inder to find the area of the lumen

length_of_plane = sqrt(length(points_struct.y(:)));
plane_intensities = reshape(plane_intensities,[length_of_plane length_of_plane]);

end

