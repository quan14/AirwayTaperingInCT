function local_min_index = ...
    First_local_min_from_index( ray_profile , index_point )
%This function finds the nearest local arg min for from the left hand side

%The input is the ray profile and reference point

%The output is the local min point on the left hand side of the index point

%% Need to contruct to matlab

%Need to consturct the indices I need to test - note that if the index
%point is less than one then the ou
loop_array = index_point:-1:2;

for i = loop_array
    
    local_min_index = i;
    
    if ~(ray_profile(local_min_index) >= ray_profile(local_min_index - 1))
        break
    end
    
    local_min_index = 1;
    
end

end

