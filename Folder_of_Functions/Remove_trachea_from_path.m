function centreline_cell_without_trachea = ...
    Remove_trachea_from_path(centreline_index_path_cell)
%Find the first bifucartion and addes it along the sturct - note assumes
%that the infomration from the function Centreline_path_extraction
%I - the arrary of sturcts of path_finder_sturct
%O - The same array but with an added ordered path vector without the
%trchea

%% Setting up the variables

centreline_cell_without_trachea = {};

%Setting up the loops
for i = 1:length(centreline_index_path_cell)
    
    %Getting the struct
    current_sturct = centreline_index_path_cell{i};
    
    %The bifurcation point of the trchea will lie on the second bi point
    trehaca_point_bi = current_sturct.bi_vector(2);
    
    %Getting the point where the path reaches the point
    trchea_index_in_path = ...
        find(trehaca_point_bi == current_sturct.path_vector ,1);
    
    %Getting the path
    path_without_trechea = ...
        current_sturct.path_vector(trchea_index_in_path:end);
    
    %Getting it to the strurct
    current_sturct.path_without_trachea = path_without_trechea;
    
    %Adding it to the output
    centreline_cell_without_trachea = ...
        cat(1,centreline_cell_without_trachea, {current_sturct});
    
end

end

