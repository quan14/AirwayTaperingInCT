function Save_tapering_and_airway_data(sturct_of_images)
%The most imporant part of the images being saved and where its bening
%saved

%The images being saved are the raw tapering image, the noisey image - they
%will be saved in spedfic folder

%% Need to find the file of interest

%The save path
folder_path = ...
    [sturct_of_images.path_of_folders '/' ];

%%  Saving the tapering image

%Need save the airway tappering sepreatly - thus the need for the loop

for i = 1:length(sturct_of_images.tapering_images_array)
    
    %Need to get the name of the airway:
    airway_name = [...
        'P_' sturct_of_images.file_name(1:end-4) ...
        '_A_' num2str(sturct_of_images.tapering_images_array(i).airway_number)...
        '.mat'];
    
    sturct_to_save = sturct_of_images.tapering_images_array(i);
    disp(['Saving ' airway_name])
    %I'm placing a backup save just in case it fucks up again
    try
        save([folder_path airway_name],...
            'sturct_to_save')
        Date_name_addition('')
    catch
        save(airway_name,'sturct_to_save')
        Date_name_addition('')
    end
    
end
end

