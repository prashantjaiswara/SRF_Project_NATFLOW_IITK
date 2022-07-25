clc
clear all
close all

%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
% basepath = 'D:\Experiments_data\PIV_20220517\Post-Processed';
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
MatFilePath = 'C:\Users\91935\OneDrive - IIT Kanpur\Natflow_Hari\PIV\PIV_2022-05-17\3_Processed_Files\MATFiles';
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------

dir_list        = UDF_get_directories( MatFilePath );

%--------------------------------------------------------------------------

total_no_of_cf = length( dir_list( :,1 ) );
total_no_of_cf=2;


for i_cf = 2 :1: total_no_of_cf
    
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
        total_no_of_Run = 1;
        
        for i_Run = 1 :1: total_no_of_Run
            
            current_Run_path     = char( current_cf_AxFy_Run_list(i_Run,1) );
            current_Run          = char( current_cf_AxFy_Run_list(i_Run,2) );
            
            %------------------------------------------------------------------

            disp(current_Run);
                       
            
            basepath = fullfile(current_Run_path, 'DatFiles');
                        
            PathOfLargestMATfile = FindLargestMATFile( basepath );
            NameOfLargestMATfile = ls( PathOfLargestMATfile );
            SizeOfLargestMATfile = dir(PathOfLargestMATfile).bytes/1024/1024/1024; % size in GB
            
            %--------------------------------------------------------------------------
            load( PathOfLargestMATfile, 'x','y','u_original','v_original' );
            %--------------------------------------------------------------------------
            
            Filename_Prefix = cell2mat( extractBetween( NameOfLargestMATfile, '','.mat') );
            
            x = cell2mat( x(1) );
            y = cell2mat( y(1) );
            
            XY_grid_FileName = strcat( Filename_Prefix,'_xy_grid', '.mat' );
            save( fullfile( basepath, XY_grid_FileName ),'x','y' );
            
            for i=1:1:3
                
                u = cell2mat(u_original(i) );
                v = cell2mat(v_original(i) );
                
                
                %----------------------------------------------------------------------
                if i>0 && i<10
                    FileName_Suffix = strcat( '00',string(i) ) ;
                    
                elseif i>9 && i<100
                    FileName_Suffix = strcat( '0',string(i)  ) ;
                    
                elseif i>99 && i<1000
                    FileName_Suffix = string(i) ;
                    
                end
                %----------------------------------------------------------------------
                
                
                uv_grid_FName = strcat( Filename_Prefix,'_', FileName_Suffix, '.mat');
                save(fullfile(basepath, uv_grid_FName),'u','v' );
                
                
            end
            
            %------------------------------------------------------------------
            
            
        end
        
    end
    
end



function PathOfLargestMATfile = FindLargestMATFile( basepath )

    PathOfFile = UDF_FindFile( basepath, '', '.mat');
    SizeOfFile = zeros( length(PathOfFile),1 );

    for i=1:1:length( PathOfFile )
        SizeOfFile(i) = dir( PathOfFile(i) ).bytes;
    end

    index_of_largest_MATfile = find( SizeOfFile == max( SizeOfFile ) );
    PathOfLargestMATfile   = PathOfFile( index_of_largest_MATfile );

end