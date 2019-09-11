function voxel_infomation_array = ...
    Voxel_size_information_from_struct( nii_struct )
%This function returns all the voxel size infomation in the sturct. - Have
%newly apted to cope with sturcts mad from Dicom_loader_for_pipleine

%The input is the sturct of the nii file

%The output is an array of voxel size - I still not sure on what the
%ordering is.

%This function has been modified

%% Acessing the infomation

if isfield(nii_struct,'Scales')
    
    %This is from the dicom reader
    voxel_infomation_array = nii_struct.Scales;
    
    %Exit the function
    return
    
end

%This is for the orignal function
voxel_infomation_array = nii_struct.hdr.dime.pixdim(2:4);


end

