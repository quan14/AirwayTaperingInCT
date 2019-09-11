function new_stop_point = ...
    Find_nearest_FHWM_from_pt( ray_profile , point )
%This is to find the nearest FHWM from a given point
%I- The 1d profile and the pointn
%O- The near point that have the FHWM

%% Getting the local max

%Finding the max point 
[max_int_array , max_location_array] = ...
    findpeaks(ray_profile);

%Need to consider the case that no peak is found
if isempty(max_int_array)
    
    new_stop_point = [];
    return
end

%Need to find the max point that is nearest to  the point speficaed
index_diff = abs(max_location_array - point);
%Find the closest max point
[~,closest_max] = min(index_diff);
%Making sure the point is unquie
closest_max = max_location_array(closest_max(1));

%Once the close max is found - we need to find the min on the left hand
%side
min_point = First_local_min_from_index(ray_profile,closest_max);

%Need to get the intensity
threshold_int = ...
    (ray_profile(closest_max) + ray_profile(min_point))/2;

%% Need to peferom the fhwm

new_stop_point = ...
    Finding_midpoint_stop(ray_profile,threshold_int,min_point,closest_max);

% %To make it easier, brake the profile into two parts - the left hand side
% ray_profile = double(ray_profile);
% lhs_profile = fliplr(ray_profile(1:point));
% rhs_profile = ray_profile((point+1):end);
% 
% %Getting the nearest local max
% [lhs_max_int , lhs_max_ind] = findpeaks(lhs_profile);
% [rhs_max_int , rhs_max_ind] = findpeaks(rhs_profile);
% 
% %etting the near loacl min
% [lhs_min_int , lhs_min_ind] = findpeaks(-lhs_profile);
% [rhs_min_int , rhs_min_ind] = findpeaks(-rhs_profile);
% 
% lhs_min_int = -lhs_min_int;
% rhs_min_int = -rhs_min_int;
% 
% lhs_mean_thres = (lhs_min_int(1) + lhs_max_int(1))/2;
% rhs_mean_thres = (rhs_min_int(1) + rhs_max_int(1))/2;
% 
% %Need to sort the limits
% lhs_ind_test = sort([lhs_max_ind(1), lhs_min_ind(1)]);
% rhs_ind_test = sort([rhs_max_ind(1), rhs_min_ind(1)]);
% 
% % Finding the pssiable thrshold
% lhs_test_profile = lhs_profile(lhs_ind_test(1):lhs_ind_test(2));
% rhs_test_profile = rhs_profile(rhs_ind_test(1):rhs_ind_test(2));
% 
% %% Need to find the argthreshold
% 
% [~,lhs_pt] = min(abs(lhs_test_profile - lhs_mean_thres));
% [~,rhs_pt] = min(abs(rhs_test_profile - rhs_mean_thres));
% 
% updated_pt = min([lhs_ind_test(1) + lhs_pt(1),...
%     rhs_ind_test(1) + rhs_pt(1)]);
% 
% new_stop_point = point + updated_pt;

end


