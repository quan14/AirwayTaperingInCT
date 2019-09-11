function is_simple = IsPointSimple(binary_image, i, j, k, use_mex_simple_point)
%Internal function

if use_mex_simple_point
    % MEX function (fast)
    is_simple = PTKFastIsSimplePoint((binary_image(i-1:i+1, j-1:j+1, k-1:k+1)));
else
    % Matlab function (slow)
    is_simple = PTKIsSimplePoint(binary_image(i-1:i+1, j-1:j+1, k-1:k+1));
end
end