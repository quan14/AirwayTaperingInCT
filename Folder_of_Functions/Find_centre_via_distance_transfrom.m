function [ gravity_row , gravity_col  ] = ...
    Find_centre_via_distance_transfrom( binary_image )
%The function computes the centre of gravity of the binary slice. Note that
%the corrdinate system will by row and col NOT x and y. The method is
%computing the distance transfrom and then find the max.

%The input a 2d binary image.

%The output is the 2d point on the image

%% Computing the distance transfrom

%Checking that binary is the correct data type.

binary_image = ~logical(binary_image);

distance_trans_output = bwdist(binary_image,'euclidean');

%% Getting the max point

[~,index_of_max] = max(distance_trans_output(:));

%I will be be assuming that the argmax is unquie. If there are distict then
%the first entry will be consider - this is an  inherant flaw of this method!! Thus
%shall not be inplmented but to do a check.

argmax_index = index_of_max(1);

%Convert the index intp row and col i.e. the Matlab index
[gravity_row , gravity_col] = ind2sub(size(binary_image),argmax_index);


end

