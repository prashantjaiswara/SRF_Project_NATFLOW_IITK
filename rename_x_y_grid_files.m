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

MatFilePath = fullfile( basepath, '3_Processed_Files', 'MATFiles');


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
%     total_no_of_AxFy = 1;
    
    for i_AxFy = 1 :1: total_no_of_AxFy
        
        current_AxFy_path     = char( current_cf_AxFy_list(i_AxFy,1) );
        current_AxFy          = char( current_cf_AxFy_list(i_AxFy,2) );
        
        disp(current_AxFy);
        
        %------------------------------------------------------------------
        %------------------------------------------------------------------
        
        current_cf_AxFy_Run_list        = UDF_get_directories( current_AxFy_path );
        
        total_no_of_Run = length( current_cf_AxFy_Run_list( :,1 ) );
%         total_no_of_Run = 1;
        
        for i_Run = 1 :1: total_no_of_Run
            
            current_Run_path     = char( current_cf_AxFy_Run_list(i_Run,1) );
            current_Run          = char( current_cf_AxFy_Run_list(i_Run,2) );
            
            %------------------------------------------------------------------

            disp(current_Run_path);
            
            PathOfFile = UDF_FindFile( current_Run_path, 'x_y_grid', '*');

            prefix =  ls(UDF_FindFile( current_Run_path, '999', '.mat') );                
            x_y_grid_Filename = strcat(prefix(1:29),'x_y_grid.mat');
            
            movefile(PathOfFile, fullfile(current_Run_path,x_y_grid_Filename));

            
            %------------------------------------------------------------------

            
        end
        
    end

end

