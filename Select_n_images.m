clc
clear all
close all

t0=datetime('now');
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
% basepath = 'D:\Experiments_data\PIV_20220517\Post-Processed';
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
RawImagePath = 'D:\Experiments_data\PIV_20220517';
DestinationPath = 'C:\Users\91935\OneDrive - IIT Kanpur\Natflow_Hari\PIV\PIV_2022-05-17\3_Processed_Files\Raw_Images_for_SetInfo';
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------




%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
dir_list        = UDF_get_directories( RawImagePath );

total_no_of_cf = length( dir_list( :,1 ) );
total_no_of_cf=6;

for i_cf = 3 :1: total_no_of_cf
    
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

            disp(current_Run);
            Copy_Four_Images(current_Run_path, current_cf, current_AxFy, current_Run, ...
                DestinationPath);
      
            %------------------------------------------------------------------
            
            
        end
    %----------------------------------------------------------------------  
    %----------------------------------------------------------------------
    end
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
end
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------


%--------------------------------------------------------------------------
t1= datetime('now');
disp( strcat('Time taken to complete the operations : ', between(t0,t1) ) ) ;

UDF_Pronounce('All operations complete.');
%--------------------------------------------------------------------------


%--------------------------------------------------------------------------
%----------------------------End of Code-----------------------------------
%--------------------------------------------------------------------------





%--------------------------------------------------------------------------
%-----------------------------Functions------------------------------------
%--------------------------------------------------------------------------


function Copy_Four_Images(current_dir, current_cf, current_AxFy, current_Run, ...
                DestinationPath)

    RawImageNames = string( extractfield( dir(...
        fullfile( current_dir,'*.bmp') ), 'name' )');
    

    disp ( UDF_check_and_make_folder(DestinationPath, current_cf) );
    disp ( UDF_check_and_make_folder( fullfile(DestinationPath, current_cf),current_AxFy ) );
    disp ( UDF_check_and_make_folder( fullfile(DestinationPath, current_cf, current_AxFy ), current_Run ) );

    BMP_list = RawImageNames(1:24);
    
    for i_img = 1 :1: length(BMP_list)
        copyfile( fullfile( current_dir,BMP_list(i_img) ) ,...
            fullfile( DestinationPath, current_cf, current_AxFy, current_Run ) ); 
        
    end
    

        
end
       
%--------------------------------------------------------------------------
%--------------------------End of Functions--------------------------------
%--------------------------------------------------------------------------

    
