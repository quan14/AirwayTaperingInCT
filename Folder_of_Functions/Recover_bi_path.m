function found_bi_sturct = ...
    Recover_bi_path(current_bi_point_sturct)
%For a single bi point we need to find the path, next gen of bi points and
%its coressponding bi points
%IMPORTANT - the bi points are removed to pervent one bi point picking up
%the other bi points as its neigbour
% %I -
% current_bi_point_sturct = struct;
% current_bi_point_sturct.bi_point = bi_point_of_interest;
% current_bi_point_sturct.centreline_image = current_centreline_image;
% O -
%For each of bi point - we will find the following
%Updated centreline with the brached removed
%The next bi points - if not then []
%The paths of each bi point
%The end of each path

%% Getting the input for the loops

bi_point = current_bi_point_sturct.bi_point;
current_centreline = current_bi_point_sturct.centreline_image;

%Dermine if the point reach is the bi point
path_ind = true;
current_point_on_path = bi_point;
bi_point_path = [bi_point];

while path_ind
    
    %Finding the neigbouring points - of the bifurcation
    neigb_index = ...
        Neigbour_pts_26_points_index_output(current_point_on_path,current_centreline);
    %Need Remove prevous points that that are known
    neigb_index = setdiff(neigb_index,bi_point_path);
    
    %Now finding the points that are non zero
    ind_neigb_index = find(current_centreline(neigb_index));
    discovered_points = neigb_index(ind_neigb_index);
    
    %There will be thress cases
    if length(discovered_points) == 1 %The path continues
        %Need to update the path and the image and points of analysis
        bi_point_path = cat(1,bi_point_path,discovered_points);
        current_centreline(discovered_points) = 0;
        current_point_on_path= discovered_points;
        
    elseif length(discovered_points) > 1
        %There is a bifurcation
        new_bi_points = discovered_points;
        bi_points_ends = bi_point_path(end);
        %update the centreline image
        current_centreline(discovered_points) = 0;
        %Need to pad the new bi points with the coressponding end points
        bi_points_ends = repmat(bi_points_ends,[1 length(new_bi_points)]);
        %kill the loop
        break
        
    else %This case reaches the end point
        new_bi_points = 0;
        bi_points_ends = bi_point_path(end);
        %Need to
        current_centreline(discovered_points) = 0;
        break
    end
end

%Now place them in the outputs as
found_bi_sturct = struct;
%Info for the new gen - note that the poinst are coreesponds to the same
%order - THHIS IS IMPORANT
found_bi_sturct.new_bi_points = new_bi_points;
found_bi_sturct.new_end_points = bi_points_ends;
%Info for the current gen
found_bi_sturct.current_bi_path = bi_point_path;
found_bi_sturct.centreline_image = current_centreline;


end

