function coeff_to_span = ...
    Construct_coeff_of_spanning_basis( sampling_interval,length_of_plane )
%Getting the ordered coeffient for the possiable linear combination - i.e.
%the coeffient that span the plane.

%The input is the smapling interval (this is usally the voxel size) and the
%length of the plane

%The output will be the array of coeffients that make the spanning set

%% Getting the limits

%Making sure the length of the plane was positive

length_of_plane = ceil(length_of_plane/2);
length_of_plane = abs(length_of_plane);

%Getting the limits
right_array = 0:sampling_interval:length_of_plane;
left_array = 0:-sampling_interval:-length_of_plane;

%Need to reorentate the left array
left_array = fliplr(left_array);

%Joining them together
coeff_to_span = cat(2,left_array,right_array(2:end));

end

