function lumen_limit = ...
    FWHM_SL_single_ray( ray_profile )
%Computes the points of the ray that gives the limit of the inner lumen

%The input in the ray proile where the first entry is around the orgin

%The output in the the limit of the lumen.

%% Creating a failsafe

if ray_profile(1) < 0.5
    
    lumen_limit = [];
    return %The functions dies if the not max is found

end

%% Getting the limit

%The last vaule that is above the 0.5
ind_ray = (ray_profile < 0.5);

lumen_limit = find(ind_ray,1);


end
