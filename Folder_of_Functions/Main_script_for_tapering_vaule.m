%This the script in order to find the tapering vaules
clear 
%Getting the paths
current_path = pwd;
addpath(genpath(current_path))
%% Load the images 

raw_name = 'github_demo_raw.nii';
seg_name = 'github_demo_seg.nii';
distal_name = 'github_demo_dital_point.nii';

%% Getting the sturct to process the images
sturct_of_images = Data_into_sturct(raw_name,distal_name,seg_name);

%% Getting the reconsturcted image
sturct_of_images = Create_taper_images(sturct_of_images);

%% Getting the area and tapering measurments
sturct_of_images = Tapering_and_area(sturct_of_images);

%% Saving the file
sturct_of_images.path_of_folders = pwd;
Save_tapering_and_airway_data(sturct_of_images)

%% Plotting an exmaple

%Getting a file - the save files will 
file_path = ls([pwd '\P*']);

%I'm plotting an exmaple
result_sturct = Unpack_loaded_sturct(file_path(1,:));
%Ploting the figure
figure
area_array = result_sturct.tapering_raw_image.area_results.phyiscal_area;
arclength = result_sturct.tapering_raw_image.arclegth;
tapering_vaule = result_sturct.tapering_raw_image.area_results.tapering;
plot(arclength,log(area_array))
ylabel('Arclength mm')
xlabel('Log Area')
title(['Taper = ' num2str(tapering_vaule) ' mm^{-1}'])