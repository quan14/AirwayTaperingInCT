function [ list_of_points_st_they_are_the_26_neigh_of_list ] = ...
    Neigbourhood_points_assuming_26_points( list_of_3D_points , binary_image )
%This function gives the 26 neibour points that are in the list of 3D
%points, note that points in the inputs are not incuded in the output of
%the data.

%The inputs that n number of 3D points in the data (in n by 3) and the binary image
%that the points come from. I need to to determine the szie.

%The list of 26 niegbours that are in the input list.

%% Getting the data

%Getting the data that is required

%This is the desfault option of the option of the output where no pioints
%are found
list_of_points_st_they_are_the_26_neigh_of_list = [];
size_of_binary_image = size(binary_image);
size_of_list_of_3d_points = size(list_of_3D_points);
number_of_points_in_the_input = size_of_list_of_3d_points(1);

%% Getting the Neigbour

%We will be generating componant of each of the 26 neighourhood

for permutation_in_i_conponent = -1:1
    
    for permutation_in_j_component = -1:1
        
        for permutation_in_k_component = -1:1
            
            %Creating the displacement vector
            displacement_to_neighbour = ...
                [permutation_in_i_conponent,permutation_in_j_component,...
                permutation_in_k_component];
            displacement_matrix_for_one_neigbourhood = ...
                repmat(displacement_to_neighbour,number_of_points_in_the_input,1);
            
            %Computing the point in the neigbourhood
            points_from_the_displacement = ...
                list_of_3D_points + displacement_matrix_for_one_neigbourhood;
            
            %Placing them in the inputs
            list_of_points_st_they_are_the_26_neigh_of_list = ...
                cat(1 , list_of_points_st_they_are_the_26_neigh_of_list , points_from_the_displacement);
            
        end
    end
end

%Gettting of the repeated rows
list_of_points_st_they_are_the_26_neigh_of_list =...
    unique(list_of_points_st_they_are_the_26_neigh_of_list,'rows');

%Need to remove the points in the inputs
[list_of_points_st_they_are_the_26_neigh_of_list, ~] = ...
    setdiff(list_of_points_st_they_are_the_26_neigh_of_list,list_of_3D_points,'rows');

%% Aviod unphyical locations

%Constructing colummn of indictor functions - the zeros

indicator_column_for_x_component = ...
    ((list_of_points_st_they_are_the_26_neigh_of_list(:,1) > 0) & ...
    (list_of_points_st_they_are_the_26_neigh_of_list(:,1) <= size_of_binary_image(1)));

indicator_column_for_y_component = ...
    ((list_of_points_st_they_are_the_26_neigh_of_list(:,2) > 0) & ...
    (list_of_points_st_they_are_the_26_neigh_of_list(:,2) <= size_of_binary_image(2)));

indicator_column_for_z_component = ...
    ((list_of_points_st_they_are_the_26_neigh_of_list(:,3) > 0) & ...
    (list_of_points_st_they_are_the_26_neigh_of_list(:,3) <= size_of_binary_image(3)));

%Combining all the indicators

indicator_for_all_component =...
    ((indicator_column_for_x_component & indicator_column_for_y_component) &...
    indicator_column_for_z_component);

%Getting all the entries with one

list_of_locations_that_are_ture = find(indicator_for_all_component);

%Removing the unphyical coords

list_of_points_st_they_are_the_26_neigh_of_list = ...
    list_of_points_st_they_are_the_26_neigh_of_list(list_of_locations_that_are_ture,:);

end

