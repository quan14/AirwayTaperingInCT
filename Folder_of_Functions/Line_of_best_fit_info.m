function [ m_const , c_const , plot_data ] = ...
    Line_of_best_fit_info( x_data_set, y_data_set )
%Gives the parameters of thhe line of best fit and the data it would
%generate from the x_data set
%I - the x and y data
%O - The const that make up y = mx + c and the data if thhe line where to
%pass in x

%% Getting the line of best fit

p_coeff = polyfit(x_data_set,y_data_set,1);

m_const = p_coeff(1);
c_const = p_coeff(2);

%% Getting the data

plot_data = m_const*x_data_set + c_const;

end

