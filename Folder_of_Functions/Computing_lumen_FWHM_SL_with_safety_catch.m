function tapering_info_sturct = ...
    Computing_lumen_FWHM_SL_with_safety_catch( tapering_image ,...
    plane_input_sturct, binary_tapering_seg )
%Taken form Kiraly06 - The fucntion is a modifcation with a safty catch so
%it won't break when no elliptial fit can be found
%The inputs is the tapering information and image

%The output is the ellpicial point and the area - note that the area will
%be in phyical

%% Post-processing image

%Remove the nan entries
tapering_image = Replace_nan_entries(tapering_image,...
    plane_input_sturct.nan_replace_int);
binary_tapering_seg = Replace_nan_entries(binary_tapering_seg,...
    plane_input_sturct.nan_replace_int);

number_of_slice = size(tapering_image,3);

%Getting the pixel size - this is to convert it into the phyical diamter
pixel_size = plane_input_sturct.physical_sampling_interval.^2;

%Getting the outputs
ellptical_info_cell = {};
ellptical_area = [];
slice_fail_case = [];

%% Perfroming the loop

for k = 1:number_of_slice
    
    %Placing the sturcture
    plane_input_sturct.cross_sectional_image = binary_tapering_seg(:,:,k);
    plane_input_sturct.center = ...
        Return_centre_pt_image(plane_input_sturct.cross_sectional_image);
    %PLacing the raw image inorder to give a more
    plane_input_sturct.raw_sectional_image = tapering_image(:,:,k);
    
    %% This is to look at the centre of the segmentation
    [centre_ind , new_centre] =  ...
        Check_centre_with_segmentation(plane_input_sturct.cross_sectional_image,...
        binary_tapering_seg(:,:,k));
    
    if ~centre_ind
        plane_input_sturct.center = fliplr(new_centre);
    end
    
    %% THIS IS WHERE WE PLACE THE SAFTY CATCH
    
    try
        %We will compute the lumen area - if we are unable then a NAN entry
        %is made
        
        %Computing the area with the describeed method
        area_info_sturct = Cross_sectional_FWHM_SL(plane_input_sturct);
        
        %Recording the infomation
        ellptical_info_cell = ...
            cat(1,ellptical_info_cell,area_info_sturct);
        
        %Recording the area in phyical information
        single_area = (area_info_sturct.area)*pixel_size;
        ellptical_area = cat(1,ellptical_area,single_area);
        
    catch
        %This is the case when the ray casting fails
        area_info_sturct = NaN;
        ellptical_info_cell = ...
            cat(1,ellptical_info_cell,area_info_sturct);
        
        %Recording the area in phyical information
        single_area = NaN;
        ellptical_area = cat(1,ellptical_area,single_area);
        
        %Recroding the failed case
        slice_fail_case = cat(1,slice_fail_case,k);
        
    end
    
end

%% Getting the outputs
tapering_info_sturct = struct;
tapering_info_sturct.elliptical_info = ellptical_info_cell;
tapering_info_sturct.phyiscal_area = ellptical_area;
tapering_info_sturct.fail_cases = slice_fail_case;

end

