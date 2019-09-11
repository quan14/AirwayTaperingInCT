function next_gen_infomation_sturct = ...
    Explore_next_gen(current_gen_info)
%This function is at the cuurent genration level - we want to find the
%paths that coreesponding current bi points, the end points of the paths
%and set up the next gen structure
% I -
% current_gen_info = struct;
% current_gen_info.current_gen = gen_array{end};
% current_gen_info.current_centreline_image = current_centreline;
%O - 
% next_gen_infomation_sturct.current_gen
% next_gen_infomation_sturct.next_gen

%% We will do this itertively

%finding the number of bi points in the moment

current_gen_struct = current_gen_info.current_gen;
bi_point_array = current_gen_struct.bi_point;
current_centreline_image = current_gen_info.current_centreline_image;

%Getting the for loop inputs

%These are for the current
path_cell_array = {};

%Thiese are the next gen
all_next_bi = [];
all_prevous_points = [];

for i = 1:length(bi_point_array)
    
    bi_point_of_interest = bi_point_array(i);
    
    %For each of bi point - we will find the following
    %Updated centreline with the brached removed
    %The next bi points - if not then []
    %The paths of each bi point
    %The end of each path
    current_bi_point_sturct = struct;
    current_bi_point_sturct.bi_point = bi_point_of_interest;
    current_bi_point_sturct.centreline_image = current_centreline_image;
    found_bi_sturct = Recover_bi_path(current_bi_point_sturct);
    
    %Need to update info for thhe current gen
    path_cell_array = ...
        cat(1,path_cell_array,{found_bi_sturct.current_bi_path});
    
    %Need to update the info for the next gen
    all_next_bi = cat(1,all_next_bi,found_bi_sturct.new_bi_points);
    all_prevous_points = cat(1,all_prevous_points,found_bi_sturct.new_end_points(:));
    
    %Need to update the current centreline image
    current_centreline_image = found_bi_sturct.centreline_image;
    
end

%Need to update the current gen and create the next gen
current_gen_struct.path_array_cell = path_cell_array;

%Need to update the next gen
next_gen_struct  = struct;
next_gen_struct.bi_point = all_next_bi;
next_gen_struct.previous_point = all_prevous_points;

%Consturcting the output variables of the function
next_gen_infomation_sturct.current_gen = current_gen_struct;
next_gen_infomation_sturct.next_gen = next_gen_struct;
next_gen_infomation_sturct.centreline_image = current_centreline_image;

end 

