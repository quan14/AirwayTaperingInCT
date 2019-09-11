function binary_image = MarkEndpoints(binary_image, fixed_points)
%Internal function


binary_image = int8(binary_image ~= 0);
binary_image(fixed_points) = 3;
end