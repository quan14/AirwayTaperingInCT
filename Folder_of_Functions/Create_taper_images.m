function [sturct_of_images] = ...
    Create_taper_images(...
    sturct_of_images)
%The function creates that creates the tapering images - the imput will be
%place into the strcut

%% Creating the centreline and spline

%Getting the slpines
[centreline_spline_cell_phyiscal,airway_number] = ...
    Selected_airway_to_spline( ...
    sturct_of_images.seg_image, ...
    sturct_of_images.start_image,...
    sturct_of_images.distal_image, ...
    sturct_of_images.raw_image, ... 
    sturct_of_images.raw_header);
%Note the index end point is just find(distal_image) in index form

%% Getting the plane inputs - the sturcts for the inperpolation

%These are the parameters that will be used - they haven't changed from the
%first application from the first clical image
plane_input_sturct = ...
    Return_airway_interpol_para(sturct_of_images.raw_header);

%Need to two sturcts - one for them is for the raw and the other is the
plane_sturct_raw = plane_input_sturct;
plane_sturct_raw.image = double(sturct_of_images.raw_image);

plane_sturct_seg = plane_input_sturct;
plane_sturct_seg.image = double(sturct_of_images.seg_image);

%Need to create a ojbect that gets the corresponding objects - note the
%table will be of variable length
tapering_tables = [];
%% Getting the tapering image
for i = 1:length(centreline_spline_cell_phyiscal)
    %% Label to start the work
    disp(['Processing ' num2str(i) 'out of' num2str(length(centreline_spline_cell_phyiscal))])
    
    %% Getting the spline of an indivual airway
    plane_sturct_raw.spline = centreline_spline_cell_phyiscal{i};
    plane_sturct_seg.spline = centreline_spline_cell_phyiscal{i};
    
    %% This is the interpolation
    tapering_raw_sturct = ...
        Cubic_resampling_and_arclength(plane_sturct_raw);
    tapering_seg_sturct = ...
        Cubic_resampling_and_arclength(plane_sturct_seg);
    
    %% Post processing of your interpolation results
    %Need to remove information - this si to save space
    fileds_to_be_removed = {'image','physical_spline',...
        'parameter_point','physical_point_interval'};
    
    %Removing the fields form the sturct
    tapering_raw_sturct.para_info = ...
        rmfield(tapering_raw_sturct.para_info,fileds_to_be_removed);
    tapering_seg_sturct.para_info = ...
        rmfield(tapering_seg_sturct.para_info,fileds_to_be_removed);
    
    %% Need to save it into a sturct
    
    %Need to get the ojbect
    current_tapering_image_entry = struct;
    current_tapering_image_entry.airway_number = airway_number(i);
    current_tapering_image_entry.tapering_raw_image = tapering_raw_sturct;
    current_tapering_image_entry.tapering_seg_image = tapering_seg_sturct;
    
    %Need to combine them into the final  table
    tapering_tables = ...
        cat(1,tapering_tables,current_tapering_image_entry);
    
    %% Label to show the end of the work
    disp(['Finish with ' num2str(i)])
end

%% The ouptut will be the sturct will the tapering image
sturct_of_images.tapering_images_array = ...
    tapering_tables;

end

