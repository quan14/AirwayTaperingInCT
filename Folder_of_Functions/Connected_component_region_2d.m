function conneted_region = ...
    Connected_component_region_2d( seed_point, image_slice )
%The performs a region growing algorthm to find the connected region. The
%connected regions is dertermined by a seed. - We assume a 4 neigbourhood
%array.

%The inputs are the seed point in 1 by 2 and the image image slice. The
%image slice is binary.

%These outputs are a list of 2d points st they in the connected set of the
%seed.

%% CORRECTION - NEED TO MODIFIED THE INPUT

seed_point = fliplr(seed_point);

%% Getting the variables

image_slice = logical(image_slice);
conneted_points_list_of = seed_point;
indicator_function = true;
size_of_image_slice = size(image_slice);

%% Impleting the Region growing algorthim

while indicator_function
    %% Getting the points
    %Getting the neigbours
    neigbouring_points = Neighbourhood_4_points_for_2D_images(seed_point,...
        image_slice);
    
    %Need to check that the neigbouring points belong to the image;
    
    %Its quicker to covert the points into linear indices
    list_of_linear_indices = sub2ind(size_of_image_slice,...
        neigbouring_points(:,2),neigbouring_points(:,1));
    
    %Testing each point in the image
    output_of_the_image = image_slice(list_of_linear_indices);
    
    %Only getting the ture positives
    true_points = find(output_of_the_image);
    
    %Getting the points that are accepted
    accepted_points = neigbouring_points(true_points,:);
    
    %Aviod_repeats
    accepted_points = setdiff(accepted_points,conneted_points_list_of,'rows');
    
    %% Apply the outputs and update the seeds
    conneted_points_list_of = cat(1,...
        conneted_points_list_of,accepted_points);
    
    %Update the seed and the indicator
    seed_point = accepted_points;
    
    
    if isempty(accepted_points)
        
        indicator_function = false;
        
    end
    
end

%Need to flip the output back
conneted_points_list_of = fliplr(conneted_points_list_of);
connected_index = sub2ind(size(image_slice),conneted_points_list_of(:,1),conneted_points_list_of(:,2));
conneted_region = zeros(size(image_slice));
conneted_region(connected_index) = true;

end

