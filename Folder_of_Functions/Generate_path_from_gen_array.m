function path_centreline_sturct = ...
    Generate_path_from_gen_array( path_finder_input )
%Return a single path in a sturct form the designmated fixed point
%I -
% path_finder_input = sturct
% path_finder_input.terminal = terminal_pt_of_interest;
% path_finder_input.last_gen = last_gen;
% path_finder_input.gen_array = gen_array;
%O - array of this
% path_centreline_sturct = struct;
% path_centreline_sturct.terminal_pt = path_finder_input.terminal;
% path_centreline_sturct.path_vector = centreline_path;
% path_centreline_sturct.bi_vector = bi_path;
% path_centreline_sturct.start_pt = path_finder_input.start;

%% Gettting the information

%Getting the variables for a loop
previous_pt = path_finder_input.terminal;
gen_array = path_finder_input.gen_array;

%The prevous gen contains the path
last_gen = path_finder_input.last_gen - 1;

%Getting the vaiables of interest
centreline_path = [];
bi_path = [];

for i = fliplr(1:last_gen)
    
    %Getting the gen and generating the end of each of the path
    gen_of_interest = gen_array{i};
    last_path_pt_vector = ...
        Last_path_pt_from_gen_sturct(gen_of_interest);
    
    %Finding the end pt
    index_location = previous_pt == last_path_pt_vector;
    
    %Getting the information
    current_path = fliplr(gen_of_interest.path_array_cell{index_location});
    current_bi = gen_of_interest.bi_point(index_location);
    
    %Combining them together
    centreline_path = cat(1,current_path,centreline_path);
    bi_path = cat(1,current_bi,bi_path);
    
    %Updatign the prevous pt for thew next interations
    previous_pt = gen_of_interest.previous_point(index_location);
    
end

%Getting the outputs ready
path_centreline_sturct = struct;
path_centreline_sturct.terminal_pt = path_finder_input.terminal;
path_centreline_sturct.path_vector = centreline_path;
path_centreline_sturct.bi_vector = bi_path;
path_centreline_sturct.start_pt = path_finder_input.start;

end

