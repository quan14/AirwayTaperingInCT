function distance_slice = Generate_distance_slice( slice_of_interest )
%Genrates a map that gives the distence from the centre of the input

%The input is the image slice - this will allow us to dertermine the size
%of the image and the location of the image

%The output is the distance map where each of the voxel

%% Genrating the slice

size_vector = size(slice_of_interest);

%Labelling the disatnce map
distance_slice = false(size_vector(1),size_vector(2));
%Getting the cenre point
centre_pt = Return_centre_pt_image(slice_of_interest);
%labelling the centre
distance_slice(centre_pt(1),centre_pt(2)) = 1;

%Finally perfrom the distenace tarnsfrom
distance_slice = bwdist(distance_slice,'euclidean');

end

