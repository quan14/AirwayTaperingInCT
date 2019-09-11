function image_with_replaced_entries = ...
    Replace_nan_entries( image_with_nan , scalar_replacement )
%Replaces the nan of the image with the scalar replacemnt - design for
%images genrated by interpolation

%The input is the image with nan vaules and the scalar replacement

%The output is the image with the replaced nan vaules

%% Creating the indictor function

indictor_image = isnan(image_with_nan);

nan_index = indictor_image;

%% Replacing the nan

image_with_replaced_entries = image_with_nan;

image_with_replaced_entries(nan_index) = scalar_replacement;


end

