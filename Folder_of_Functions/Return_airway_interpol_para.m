function plane_input_sturct = Return_airway_interpol_para( 	varargin )
%These are the parameters used for the interpolation

%This is for the interpolation
plane_input_sturct = struct;
plane_input_sturct.physical_plane_length = 40;
plane_input_sturct.physical_sampling_interval= 0.3;
plane_input_sturct.spline_sampling_interval = 0.25;

%The inputs for the area - They will place in the same ray
plane_input_sturct.rays = 50;
plane_input_sturct.ray_interval = 0.2;
plane_input_sturct.nan_replace_int = 0;

if ~isempty(varargin)
    plane_input_sturct.voxel_size = ...
        Voxel_size_information_from_struct(varargin{1});
end
end

