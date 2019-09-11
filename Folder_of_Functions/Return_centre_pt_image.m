function array_croods = ...
    Return_centre_pt_image( test_image )
%This returns the points of the image coords that atre in the centre - the
%ouput is in the same crood convention

%The input is the image

%The output is the mid point

%% Gettung the size of the image

size_vector = size(test_image) + 1;

array_croods = ceil(size_vector/2);


end

