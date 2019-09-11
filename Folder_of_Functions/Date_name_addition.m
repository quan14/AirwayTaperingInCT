function string_with_date = Date_name_addition( front_string )
%This function inputs the date and time at the point when this function
%calls on the back of the input string.

%The input is the string without the date

%The output is the sting with the date when this function is called;

%% Getting the date string

date_string = char(datetime('now','TimeZone','local','Format','d_MM_y_HH_mm_ss'));

%Note: The char coverts the data type as the same with any string

%% Placing it to the back string

string_with_date = [front_string '_' date_string];

end

