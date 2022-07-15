clc
clear all
close all

%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
basepath = 'D:\2021\Experiments\PIV\2022-05-17\Data';
% basepath = 'D:\Experiments_data\PIV_20220517\Post-Processed';

%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
% DaFilesPath = 'D:\Experiments_data\PIV_20220517\Post-Processed';
% MatFilePath = 'C:\Users\91935\OneDrive - IIT Kanpur\Natflow_Hari\PIV\PIV_2022-05-17\3_Processed_Files\MATFiles';
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------

dir_list        = UDF_get_directories( basepath );

%--------------------------------------------------------------------------

total_no_of_cf = length( dir_list( :,1 ) );
total_no_of_cf=7;


for i_cf = 5 :1: total_no_of_cf
    
    current_cf_path     = char( dir_list(i_cf,1) );
    current_cf          = char( dir_list(i_cf,2) );
    
%     disp(current_cf);
    
    %----------------------------------------------------------------------
    %----------------------------------------------------------------------
    current_cf_AxFy_list        = UDF_get_directories( current_cf_path );
    
    total_no_of_AxFy = length( current_cf_AxFy_list( :,1 ) );
%     total_no_of_AxFy = 1;
    
    for i_AxFy = 1 :1: total_no_of_AxFy
        
        current_AxFy_path     = char( current_cf_AxFy_list(i_AxFy,1) );
        current_AxFy          = char( current_cf_AxFy_list(i_AxFy,2) );
        
%         disp(current_AxFy);
        
        %------------------------------------------------------------------
        %------------------------------------------------------------------
        
        current_cf_AxFy_Run_list        = UDF_get_directories( current_AxFy_path );
        
        total_no_of_Run = length( current_cf_AxFy_Run_list( :,1 ) );
        total_no_of_Run = 1;
        
        for i_Run = 1 :1: total_no_of_Run
            
            current_Run_path     = char( current_cf_AxFy_Run_list(i_Run,1) );
            current_Run          = char( current_cf_AxFy_Run_list(i_Run,2) );
            
            %------------------------------------------------------------------

%             disp(current_Run);

            PIVLab_Output_File_location = fullfile( current_Run_path, 'DatFiles');

            PathOfFile = UDF_FindFile( PIVLab_Output_File_location, '', '.mat');
            NameOfFile = ls( PathOfFile )
% 
%             NewFileName = strcat( current_cf, '_', current_AxFy, '_R', string(i_Run), ...
%                 '_S12I16.mat' );

%             movefile(PathOfFile, fullfile(PIVLab_Output_File_location , NewFileName));

            
            %------------------------------------------------------------------

            
        end
        
    end

end

