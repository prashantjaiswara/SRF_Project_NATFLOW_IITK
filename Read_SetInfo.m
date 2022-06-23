clc
clear all
close all

%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
% basepath = 'D:\Experiments_data\PIV_20220517\Post-Processed';
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
basepath    = 'C:\Users\91935\OneDrive - IIT Kanpur\Natflow_Hari\PIV\PIV_2022-05-17'; 
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

SetInfoPath = fullfile( basepath, '1_Processing_Parameters');
MatFilePath = fullfile( basepath, '3_Processed_Files', 'MATFiles');

%--------------------------------------------------------------------------

PathOfFile = UDF_FindFile( SetInfoPath, 'Master_SetInfo_c05', '*');

[p_x_img , p_y_img , Total_Pixel_X , Total_Pixel_Y ,mm_per_pixel , Case_list,...
    ImageFileNameList_with_theta, theta_list_across_AxFy ]...
    = UDF_get_NACA_Info(PathOfFile,'');

%--------------------------------------------------------------------------

dir_list        = UDF_get_directories( MatFilePath );

%--------------------------------------------------------------------------

total_no_of_cf = length( dir_list( :,1 ) );
total_no_of_cf=1;

for i_cf = 1 :1: total_no_of_cf
    
    current_cf_path     = char( dir_list(i_cf,1) );
    current_cf          = char( dir_list(i_cf,2) );
    
    disp(current_cf);
    
    %----------------------------------------------------------------------
    %----------------------------------------------------------------------
    current_cf_AxFy_list        = UDF_get_directories( current_cf_path );
    
    total_no_of_AxFy = length( current_cf_AxFy_list( :,1 ) );
    total_no_of_AxFy = 1;
    
    for i_AxFy = 1 :1: total_no_of_AxFy
        
        current_AxFy_path     = char( current_cf_AxFy_list(i_AxFy,1) );
        current_AxFy          = char( current_cf_AxFy_list(i_AxFy,2) );
        
        disp(current_AxFy);
        
        %------------------------------------------------------------------
        %------------------------------------------------------------------
        
        current_cf_AxFy_Run_list        = UDF_get_directories( current_AxFy_path );
        
        total_no_of_Run = length( current_cf_AxFy_Run_list( :,1 ) );
        total_no_of_Run = 1;
        
        for i_Run = 1 :1: total_no_of_Run
            
            current_Run_path     = char( current_cf_AxFy_Run_list(i_Run,1) );
            current_Run          = char( current_cf_AxFy_Run_list(i_Run,2) );
            
            %------------------------------------------------------------------

            disp(current_Run_path);
            load( fullfile(current_Run_path,'D220517_c05_A10F1_R1_S12_I16_000000025.mat') );
            x1 = x - p_x_img*mm_per_pixel -15;
            y1 = y - p_y_img*mm_per_pixel;
            
            %------------------------------------------------------------------

            
        end
        
    end

end


