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

%--------------------------------------------------------------------------


ImagePath = 'C:\Users\91935\OneDrive - IIT Kanpur\Natflow_Hari\PIV\PIV_2022-05-17\3_Processed_Files\Raw_Images_for_SetInfo\c05\A10F1\Run_1';


%--------------------------------------------------------------------------


[p_x_img , p_y_img , Total_Pixel_X , Total_Pixel_Y ,...
    mm_per_pixel , First_motion_in_ImageNo, Case_list,...
    theta_list_across_AxFy ]...
    = UDF_get_NACA_Info(PathOfFile,'');

S   = 6;              % Image acquisition frequency in Hz
del_t   = 1/S;

ImageFileName = First_motion_in_ImageNo ;

chord =  str2double( extractBetween( Case_list, 'c','_A')); 
amp   =  str2double( extractBetween( Case_list, 'A','F'));
freq  =  str2double( extractBetween( Case_list, 'F','_R'));
Run   =  str2double( extract( Case_list, strlength( Case_list ) ) );
First_motion_in_ImageNo = str2double( extractBetween(First_motion_in_ImageNo,'s','.') );

chordLen = 50/mm_per_pixel;
t0_list  = zeros( length(chord), 1 );
omega_t0 = zeros( length(chord), 1 );

px = p_x_img;
py = p_y_img;

naca = UDF_create_airfoil( chordLen, px , py );


%--------------------------------------------------------------------------
PathOfImages = UDF_FindFile( ImagePath, '', '.bmp');


% I = imread ( fullfile( ImagePath , ImageFileName(1) ) );

% imshow(I);
% length(chord)

%--------------------------------------------------------------------------

for i_AxFy =  1 : 1 : 1
    
    if  abs( theta_list_across_AxFy(i_AxFy)) > amp(i_AxFy)
        
        updated_theta = sign(theta_list_across_AxFy(2))*amp(i_AxFy);
        
        disp( strcat("Correcting the theta value of case: '", Case_list(i_AxFy),...
        "' from theta = ",string(theta_list_across_AxFy(i_AxFy))," to theta = ",...
            string(updated_theta) ) );
        
        theta_list_across_AxFy(i_AxFy) = updated_theta;
       
    end
    
    t0_list ( i_AxFy ) = ( acos(   theta_list_across_AxFy(i_AxFy) / amp(i_AxFy) )   )/ (2 * pi * freq(i_AxFy) );
%     omega_t0( i_AxFy ) = 2*180*freq(i_AxFy)*t0_list( i_AxFy );

    
    
    for i_image_steps = First_motion_in_ImageNo(i_AxFy) : 2: First_motion_in_ImageNo(i_AxFy)+10
        
        theta = amp(i_AxFy) * cos(2 * pi * freq(i_AxFy) * ( t0_list ( i_AxFy ) + del_t*...
            (First_motion_in_ImageNo(i_AxFy) - i_image_steps )*0.5 ) );

        figure
        
        hold on
        I= imread( PathOfImages(i_image_steps)  );
        imshow( I );
        
        hold on

        naca_at_theta = UDF_rotz_shape( naca, [px, py ], theta );
        plot( naca_at_theta(:,1) , naca_at_theta(:,2)  );
        
        hold on
        

    end
    

    
    
    
    
    
end
% T = cell( length(t0_list) + 1 , 4);
% 
% T(1,:)    =  {'theta_list', 't0', 'omega_t0', 'no_of_image_steps' };
% T(2:end,:)=   num2cell( [theta_list_across_AxFy, t0_list, omega_t0, no_of_image_steps]) ;

