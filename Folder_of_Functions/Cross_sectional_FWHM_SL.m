function [ elipllical_sturct ] = ...
    Cross_sectional_FWHM_SL( input_parameters )
%This is to perfrom the ray casting measurents - the input is in a sturct
% as
%     input_parameters
%     input_parameters.cross_sectional_image
%     input_parameters.rays
%     input_parameters.center
%     input_parameters.ray_interval
%     input_parameters.nan_replace_int
% The basis of the code is base on the description - Virtual Bronchoscopy for Quantitative Airway Analysis
% by A P Kiraly et al.

%The output will be sturct containing the major and minor lengths as well
%as all the stop points
elipllical_sturct = struct;
% elipllical_sturct.x_stop
% elipllical_sturct.y_stop
% elipllical_sturct.elipllical_info
% elipllical_sturct.area

%% Need to revmove and replave nan vaules

%Getting the index
nan_index = isnan(input_parameters.cross_sectional_image);
input_parameters.cross_sectional_image(nan_index) = input_parameters.nan_replace_int;

%% Getting the rays

%computing the poalar croods
ray_angle_interval = 2*pi/input_parameters.rays;

%Getting the range limit of the ray which will be the shortest distance
%from the centre to the bounadry
image_size_vector = size(input_parameters.cross_sectional_image);

%Need to find the limits of the raw
limit_row = abs(image_size_vector(1) - input_parameters.center(1));
limit_col = abs(image_size_vector(2) - input_parameters.center(2));

ray_length_limit = min(limit_row,limit_col);

%Getting an array of vaules for polar croods
radial_vaules = 0:input_parameters.ray_interval:ray_length_limit;
theta_vaules = 0:ray_angle_interval:2*pi;

%Getting the points in the cat corods
x_cos = cos(theta_vaules);
y_sin = sin(theta_vaules);

%Combining the two vector together - each is on each col i.e (:,i)
x_component = radial_vaules'*x_cos + input_parameters.center(1);
y_component = radial_vaules'*y_sin + input_parameters.center(2);

%Now need to find the coressponding intensity - we will use the cubic
%interpolation - need to make it double type
input_parameters.cross_sectional_image = ...
    double(input_parameters.cross_sectional_image);

plain_intensity = interp2(input_parameters.cross_sectional_image,x_component(:),...
    y_component(:));

raw_intensity = interp2(input_parameters.raw_sectional_image,...
    x_component(:),...
    y_component(:));

%Need to reshape
plain_intensity = ...
    reshape(plain_intensity,[size(y_component,1) size(y_component,2)]);
raw_intensity = ...
    reshape(raw_intensity,[size(y_component,1) size(y_component,2)]);

%% We will now implememnt the FHWM

%Need to find the length of the ray - this need a loop
number_of_rays = size(y_component,2);
x_stop = [];
y_stop = [];
stop_point_array = [];

%performing a loop
for ray = 1:number_of_rays
    
    ray_profile = plain_intensity(:,ray);
    ray_pro_raw = raw_intensity(:,ray);
    
    %Where the 
    point_stop = FWHM_SL_single_ray(ray_profile);
    
    if isempty(point_stop)
        %This will skip the loop if no point is found
        continue 
    end
    
    %Need to the get a use the information of the raw imformation
    point_stop = Find_nearest_FHWM_from_pt(ray_pro_raw,point_stop);
    
    if isempty(point_stop)
        %This will skip the loop if no point is found
        continue
    end
    
    stop_point_array = cat(1,stop_point_array,point_stop);
    %getting the coords - we will be using cncentration
    x_point = x_component(point_stop,ray);
    y_point = y_component(point_stop,ray);
    
    %Adding the points together
    x_stop = cat(1,x_stop,x_point);
    y_stop = cat(1,y_stop,y_point);
    
end

%% Need ot remove the outilers

%[~, non_outlier_index ] =  Remove_Outliers(stop_point_array,0);

%Perform the Ellipitcal fitting:
elipllical_sturct.x_stop = x_stop;
elipllical_sturct.y_stop = y_stop;
%elipllical_sturct.radial_map = raw_intensity;

elipllical_sturct.elipllical_info = Elliptical_fitting(elipllical_sturct.x_stop ,elipllical_sturct.y_stop);
elipllical_sturct.area = elipllical_sturct.elipllical_info(3)*elipllical_sturct.elipllical_info(4)*pi;

end

