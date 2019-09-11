function [mid_point_of_trachea, mid_point_in_index] = ...
    Mid_point_trachea_with_dis_image(distance_image)
%Find the point of the trchca at some z point without finding the
%centreline explictly

%The input is the path of the segmentation

%The output is the mid point of the treacha


%% Finding the first start point

%The airways always start at the end of the image
axial_point = size(distance_image,3);
indictor_start = true;

%Need to find the start point
while indictor_start
    
    first_slice = distance_image(:,:,axial_point);
    
    if isempty(find(first_slice(:), 1))
        
        axial_point = axial_point - 1;
        
    else
        
        indictor_start = false;
        
    end
    
end

%% Need to find the big slice

%we will use a montonic squence

current_point = axial_point;
indictor_max = true;

while indictor_max
    current_slice = distance_image(:,:,current_point);
    axial_centre = current_point - 1;
    next_slice = distance_image(:,:,axial_centre);
    
    if max(next_slice(:)) > max(current_slice(:))
        current_point = current_point - 1;
    else
        indictor_max = false;
        axial_centre = axial_centre - 1;
    end
end

%% Geeting the centre

plane_with_centre = distance_image(:,:,axial_centre);
max_point = max(plane_with_centre(:));
%assuming that the max point is near the centre
index_max = find(plane_with_centre == max_point , 1);
%Finally comvert into plane croods
[x_centre,y_centre] = ind2sub(size(plane_with_centre),index_max);

%% Thus the final point will be:

mid_point_of_trachea = [x_centre,y_centre,axial_centre];
mid_point_in_index = sub2ind(size(distance_image),x_centre,y_centre,axial_centre);
end

