function [p_x_img , p_y_img , Total_Pixel_X , Total_Pixel_Y ,...
    mm_per_pixel , Case_list,...
    ImageFileNameList_with_theta, theta_list_across_AxFy ]...
    = UDF_get_NACA_Info(SetInfoPath, CSVFileName)



    %----------------------------------------------------------------------
    %--------------------To make the function as File----------------------
    %----------------------------------------------------------------------
    % clc
    % clear all
    % close all
    % 
    % basepath='C:\Users\91935\OneDrive - IIT Kanpur\Natflow_Hari\PIV\PIV_2022-05-17';
    % SetInfoPath = fullfile(basepath,'1_Processing_Parameters');
    % CSVFileName = 'Master_SetInfo_c05.csv';
    %----------------------------------------------------------------------
    %----------------------------------------------------------------------
    
    
T_SetInfo=readtable(fullfile(SetInfoPath, CSVFileName));
% T_MicroVec=readtable(fullfile(processing_parameter_path,'MicroVec_Ruler_settings.csv'));

%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
Total_Pixel_X   = T_SetInfo.Total_Pixel_X;
Total_Pixel_Y   = T_SetInfo.Total_Pixel_Y;

ImageFileNameList_with_theta   = string(T_SetInfo.Filename);

L_x             = T_SetInfo.L_x;
L_y             = T_SetInfo.L_y;
T_x             = T_SetInfo.T_x;
T_y             = T_SetInfo.T_y;

mm_per_pixel    = T_SetInfo.mm_per_pixel;
mm_per_pixel    = mm_per_pixel(1);

%--------------------------------------------------------------------------
%--------------------------------------------------------------------------


%--------------------------------------------------------------------------
%---------------------------Calculations-----------------------------------
%--------------------------------------------------------------------------

% c_L_img = mean( (   (T_x-L_x).^2 + (T_y-L_y).^2 ).^(1/2)  );

p_x_img = mean( (T_x-L_x)*0.3 + L_x ) ;
p_y_img = mean( (T_y-L_y)*0.3 + L_y ) ;
%--------------------------------------------------------------------------
Case_list     =  strcat('c',string(T_SetInfo.FlapLength),...
    '_A',string(T_SetInfo.MaxAmplitude),'F',string(T_SetInfo.Frequency),...
    '_R',string(T_SetInfo.Run_no) );
%--------------------------------------------------------------------------
theta_list_across_AxFy    =  (180/pi)*atan( (T_y-L_y)./(T_x-L_x) );

%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

end
