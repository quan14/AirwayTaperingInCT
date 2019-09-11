function [ resample_image_and_length_struct ] = ...
    Cubic_resampling_and_arclength( input_struct_info )
%Generates the the resmapled image by cubic interpolation

%The inputrs will be a sturct with the following inputs
% plane_input_sturct = struct;
% plane_input_sturct.spline = smooth_spline;
% plane_input_sturct.image = raw_image;
% plane_input_sturct.parameter_point = k;
% plane_input_sturct.physical_plane_length = 50;
% plane_input_sturct.physical_sampling_interval = 1;
% plane_input_sturct.spline_sampling_interval = 0.5
% plane_input_sturct.voxel_size = Voxel_size_information_from_struct(raw_sturct);

%% Need to modified the spline

%Since I'm using very old functions - I've need to convert them into the
%same sturct I was using - also I don't want to correct the mispelling
input_struct_info.physical_spline = input_struct_info.spline;
input_struct_info.physical_point_interval = input_struct_info.physical_sampling_interval;

%The outputs will be a struct
resample_image_and_length_struct = struct;
%resample_image_and_length_struct.resample_image
%resample_image_and_length_struct.arclegth
%Note that the arcelnght is defined at the start of the crina

%% Consturct each slice via loop

%Getting the loop to generate each slice and the inputs
tapering_image = [];
tapering_arclength = [];

spline_para_limit = input_struct_info.spline.breaks(end);
spline_para_interval = input_struct_info.spline_sampling_interval;

for i = 0:spline_para_interval:spline_para_limit
    
    input_struct_info.parameter_point = i;
    
    %Getting the croods for the resmapling intensties
    plane_pt_struct = ...
        Consturct_croods_on_normal_plane(input_struct_info);
    
    %Getting the intensities
    resample_plane = ...
        Plan_intensities_via_matlab_interpol(...
        input_struct_info.voxel_size,input_struct_info.image,plane_pt_struct);
    
    %I'm conern about the amount of memoery
    clear plane_pt_struct
    
    %Saving the image
    tapering_image = cat(3,tapering_image,resample_plane);
    
    %Computing the arclength
    current_arclength = Arc_length_to_point(i,input_struct_info.physical_spline);
    
    %Finally collecting the arclength
    tapering_arclength = cat(1,tapering_arclength,current_arclength);
    
end

% Placing everything in the output sturct
resample_image_and_length_struct.resample_image = tapering_image;
resample_image_and_length_struct.arclegth = tapering_arclength;
resample_image_and_length_struct.para_info = input_struct_info;
end