function unit_tangent_point = ...
    Unit_tangent_from_spline( para_point , spline_sturct )
%Compute the unit tangent point form a given para point. The struct is
%base on the matlab curve fitting toolbox

%% Getting the tangent using differentation form matlab

diff_spline = fnder(spline_sturct,1);

%% Getting the unit tangent

%Getting the tangent
tangent_vector = fnval(diff_spline,para_point);

clear spline_sturct

%Getting the final output
unit_tangent_point = Return_unit_vector(tangent_vector);

end

