function index_mid_point = ...
    Finding_midpoint_stop( global_ray_profile,...
    mid_threshold , min_limit, max_limit)
%Getting the the mid point of the threshold - assumes the ray profile is
%montonic
%O - the index of the array

%% Setting up

%Assumes that min point comes first
index_domain = min_limit:max_limit;
index_intensity = global_ray_profile(index_domain);

%Assumes that the inteval is montonic
ind_array = mid_threshold <= index_intensity;
index_limit = find(ind_array,1);

%Now need to find the threhold - need to consider two cases
if index_limit == 1
    
    index_mid_point = index_domain(1);
    
else
    
    upper_range_int = index_intensity(index_limit);
    lower_range_int = index_intensity(index_limit - 1);
    
    %Need need to find the closest neigbour
    upper_neig_dist = abs(upper_range_int - mid_threshold);
    lower_neig_dist = abs(lower_range_int - mid_threshold);
    
    if upper_neig_dist <= lower_neig_dist
        index_mid_point = index_domain(index_limit);
    else
        index_mid_point = index_domain(index_limit - 1);
    end
    
end

end

