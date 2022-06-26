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

%--------------------------------------------------------------------------

PathOfFile = UDF_FindFile( SetInfoPath, 'Master_SetInfo_c05', '*');

[p_x_img , p_y_img , Total_Pixel_X , Total_Pixel_Y ,...
    mm_per_pixel , First_motion_in_ImageNo, Case_list,...
    ImageFileNameList_with_theta, theta_list_across_AxFy ]...
    = UDF_get_NACA_Info(PathOfFile,'');

total_cases= length(Case_list);

for i_case = 1 :1: total_cases
    
    current_case = char( Case_list(i_case) );
    
    amp  = str2num( current_case(end-6:end-5) );
    freq = current_case(end-3);
    
    theta_25th_image = theta_list_across_AxFy(i_case);
    
    
    

    
end
