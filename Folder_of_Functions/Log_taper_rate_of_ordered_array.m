function [ log_taper_rate ] =  ...
    Log_taper_rate_of_ordered_array( array_x,array_y )
% Computes the log taper rate of the input array
%I: the realationship between the z and y
% O: The log grad - a scalar constant

%% Log and then find the taper rate

logged_arrary = log(array_y);

%finding the taper rate 

[log_taper_rate,~] = Line_of_best_fit_info(array_x,logged_arrary);

end

