function last_generation = ...
    Find_last_generation( index_of_interest , gen_array )
%Finds the last generation where the index is of interest
%I - the gen array and the pt of interst
%O - the last generttaion is found - if none then there is a emtpy set

%% Quicker to go revrse

last_generation = [];

for i = fliplr(1:length(gen_array))
    
    gen_sturct = gen_array{i};
    
    if any(index_of_interest == gen_sturct.previous_point)
        last_generation = i;
        break
    end


end

