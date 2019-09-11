function last_path_pt = Last_path_pt_from_gen_sturct(gen_of_interest)
%Finds the end of pts of the path - the order is the same i.e. will incl
%zeros
%I - gen sturct
%O - array of end points from the path

%% Doing a loop

%Getting the vaiables
path_cell_array = gen_of_interest.path_array_cell;

last_path_pt = [];

for i = 1:length(path_cell_array)
    
    path_vector = path_cell_array{i};
    
    %Getting the end pt
    last_path_pt = cat(1,last_path_pt,path_vector(end));


end

