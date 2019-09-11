function plane_output_pt_sturct = ...
    Consturct_croods_on_normal_plane( plane_input_sturct )
%Gives a set of points in is that normal to the tangent of the plane

%The input is the set of sturct that dertermines the plane size and
%sampling interval - an exmaple of the inputs atre:
% plane_input_sturct = struct;
% plane_input_sturct.physical_spline = phyical_smooth_spline;
% plane_input_sturct.parameter_point = k;
% plane_input_sturct.physical_plane_length = 50;
% plane_input_sturct.physical_point_interval = 1;


%The output is set of points the corresponds to the plane.

%% Getting poins via each function

%Getting the position
position_point = fnval(plane_input_sturct.physical_spline,...
    plane_input_sturct.parameter_point);

%Getting the tangent
position_tangent = Unit_tangent_from_spline(plane_input_sturct.parameter_point,...
    plane_input_sturct.physical_spline);

%Getting the basis i.e. the two normal that spans the plane
basis_vector = ...
    Orthonormal_basis_with_tangent_vector(position_tangent);

%Getting the crossection information
plane_output_pt_sturct = Grids_coords_for_plane(...
    basis_vector(:,3),...
    basis_vector(:,2),...
    position_point,...
    plane_input_sturct.physical_plane_length,...
    plane_input_sturct.physical_point_interval);


end

