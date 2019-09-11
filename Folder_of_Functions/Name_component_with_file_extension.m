function [ str_array_cell ] = ...
    Name_component_with_file_extension( file_string )
%Getting the file components and removes that file compoenents
%I - the file name
%O - the components of the names in a cell

%% Removing the file type

[~,file_name,~] = fileparts(file_string);

%% Getting file components

%Getting the components = this fuction assumes that the compoents aref
%seprated by "_"

str_array_cell = strsplit(file_name,'_');


end

