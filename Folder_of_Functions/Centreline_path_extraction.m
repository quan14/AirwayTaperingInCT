function [path_sturct_cell,refined_terminal_pts]...
    = Centreline_path_extraction( centreline_image_sturct )
%The following function will give the set of paths rquired
%I - Have the sturct as follows
% I.centreline_image
% I.index_struct
%O - array of this
% path_centreline_sturct = struct;
% path_centreline_sturct.terminal_pt = path_finder_input.terminal;
% path_centreline_sturct.path_vector = centreline_path;
% path_centreline_sturct.bi_vector = bi_path;
% path_centreline_sturct.start_pt = path_finder_input.start;


%% To begin need to with genration zero

%To begin
gen_struct = struct;
gen_struct.bi_point = centreline_image_sturct.index_struct.start_point;
gen_struct.previous_point = 0;

%Now where start at the first generation
gen_array = {gen_struct};

%We don't know the number of genrations do need to set an indicator
gen_not_finish = true;
%We also need to get the current centreline image
current_centreline = centreline_image_sturct.centreline_image;

%We now begin the loop finding all the paths for each of the generation
while gen_not_finish
    
    %What we need to get the paths for this current gentation and the bi
    %points of the next genration and having each of the coressponding end
    %points - to processed we need the infomration for the current gen and
    %the state of the centreline image
    current_gen_info = struct;
    current_gen_info.current_gen = gen_array{end};
    current_gen_info.current_centreline_image = current_centreline;
    
    next_gen_infomation_sturct = Explore_next_gen(current_gen_info);
    
    %Need to update the gen array - sturct will contain all the paths
    gen_array{end} = next_gen_infomation_sturct.current_gen;
    %Add the new gen where the paths have not found
    gen_array = cat(1,gen_array,{next_gen_infomation_sturct.next_gen});
    
    %Need to update the centreline image
    current_centreline = next_gen_infomation_sturct.centreline_image;
    
    %Check if the consider the current if any more bi points exist
    if ~(any(next_gen_infomation_sturct.next_gen.bi_point))
        %Kill the while loop is reach the end
        break
    end

end

%% Getting the paths

%Getting the terminal points
terminal_paths = centreline_image_sturct.index_struct.terminal_point;
path_sturct_cell = {};
refined_terminal_pts = [];
for i = 1:length(terminal_paths)
    
    terminal_pt_of_interest = terminal_paths(i);
    
    %Finding the last generation that it lies
    last_gen = Find_last_generation( terminal_pt_of_interest , gen_array );
    
    if isempty(last_gen)
        %To be place if the final point cannot be reached
        disp(['Cannot find ' num2str(terminal_pt_of_interest)])
        continue
        
    end
    
    %Getting the path
    path_finder_input = struct;
    path_finder_input.terminal = terminal_pt_of_interest;
    path_finder_input.last_gen = last_gen;
    path_finder_input.gen_array = gen_array;
    path_finder_input.start = centreline_image_sturct.index_struct.start_point;
    
    path_centreline_sturct = ...
        Generate_path_from_gen_array( path_finder_input );
    
    path_sturct_cell = cat(1,path_sturct_cell,{path_centreline_sturct});
    refined_terminal_pts = cat(1,refined_terminal_pts,terminal_pt_of_interest);
    
end

end

