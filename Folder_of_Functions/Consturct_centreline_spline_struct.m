function spline_cell = ...
    Consturct_centreline_spline_struct(centreline_index_path_cell,raw_image,voxel_size)
%This function converts the centreline points from the list of indices to
%the raw image

%The input is the list of centrelins with the cell data type and the raw
%image

%The output is the cell with the coressponding spline sturct

%% Getting the number of centreline points

spline_cell = {};

number_of_centrelines = length(centreline_index_path_cell);

for i = 1:number_of_centrelines
    
    path_cell = centreline_index_path_cell{i};
    
    %Getting the path - we chose the one without the trechea
    index_centreline = path_cell.path_without_trachea;
    
    %Need to be converted into points
    centreline_spline = Smooth_spline_struct_with_index(raw_image,index_centreline,voxel_size);
    
    %Need collecting all the spline with the 
    spline_cell = cat(1,spline_cell,centreline_spline);
end

end

