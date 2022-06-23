clc
clear all
close all

%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
% basepath = 'D:\Experiments_data\PIV_20220517\Post-Processed';
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
DaFilesPath = 'D:\Experiments_data\PIV_20220517\Post-Processed';
MatFilePath = 'C:\Users\91935\OneDrive - IIT Kanpur\Natflow_Hari\PIV\PIV_2022-05-17\3_Processed_Files\MATFiles';
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------



%--------------------------------------------------------------------------

dir_list        = UDF_get_directories( DaFilesPath );

%--------------------------------------------------------------------------

total_no_of_cf = length( dir_list( :,1 ) );
total_no_of_cf=1;

for i_cf = 1 :1: total_no_of_cf
    
    current_cf_path     = char( dir_list(i_cf,1) );
    current_cf          = char( dir_list(i_cf,2) );
    
%     disp(current_cf);
    
    %----------------------------------------------------------------------
    %----------------------------------------------------------------------
    current_cf_AxFy_list        = UDF_get_directories( current_cf_path );
    
    total_no_of_AxFy = length( current_cf_AxFy_list( :,1 ) );
%     total_no_of_AxFy = 1;
    
    for i_AxFy = 2 :1: total_no_of_AxFy
        
        current_AxFy_path     = char( current_cf_AxFy_list(i_AxFy,1) );
        current_AxFy          = char( current_cf_AxFy_list(i_AxFy,2) );
        
%         disp(current_AxFy);
        
        %------------------------------------------------------------------
        %------------------------------------------------------------------
        
        current_cf_AxFy_Run_list        = UDF_get_directories( current_AxFy_path );
        
        total_no_of_Run = length( current_cf_AxFy_Run_list( :,1 ) );
%         total_no_of_Run = 1;
        
        for i_Run = 1 :1: total_no_of_Run
            
            current_Run_path     = char( current_cf_AxFy_Run_list(i_Run,1) );
            current_Run          = char( current_cf_AxFy_Run_list(i_Run,2) );
            
            %------------------------------------------------------------------

            % disp(current_Run);
            [DatFileNames, x, y, u, v, VelMagtd, vort] = Dat_to_MAT( fullfile(current_Run_path,'DatFiles'),...
                current_cf, current_AxFy, current_Run, MatFilePath );
            
            %------------------------------------------------------------------

            
        end
        
    end

end


function [ DatFileNames, x, y, u, v, VelMagtd, vort] = Dat_to_MAT(current_dir,...
    current_cf, current_AxFy, current_Run, MatFilePath)

    DatFileNames = string( extractfield( dir(...
        fullfile( current_dir,'*.dat') ), 'name' )');
    

    disp ( UDF_check_and_make_folder(MatFilePath, current_cf) );
    disp ( UDF_check_and_make_folder( fullfile(MatFilePath, current_cf),current_AxFy ) );
    disp ( UDF_check_and_make_folder( fullfile(MatFilePath, current_cf, current_AxFy ), current_Run ) );

    
    last_Dat_no = length(DatFileNames) - 2;
%     last_Dat_no = 102;
    for i_Dat = 6 :1: last_Dat_no
        
        %         disp( DatFileNames(i_Dat) );
        [ x, y, u, v, VelMagtd, vort] = Data_Reshape( current_dir, DatFileNames(i_Dat) );
        %         disp(MatFile);
        
        DatFileName = char (DatFileNames(i_Dat) );
        current_MATFileName = strcat( DatFileName(1:12),current_AxFy,'_R',current_Run(end),'_',...
            DatFileName(end-20:end-4),'.mat');
        save( fullfile( MatFilePath, current_cf, current_AxFy , current_Run , current_MATFileName),...
            'x', 'y', 'u', 'v', 'VelMagtd' , 'vort' );
        
    end
       
end

function  [ x, y, u, v, VelMagtd, vort] = Data_Reshape(DatFilePath, DatFileName)

    mydata= importdata( fullfile(DatFilePath, DatFileName) ) ;
    
        x        = mydata.data(:,1);
        y        = mydata.data(:,2);
        
        u        = mydata.data(:,4);
        v        = mydata.data(:,5);
        
        VelMagtd = mydata.data(:,7);
        vort     = mydata.data(:,8);
        
        var_list=[x, y, u, v, VelMagtd, vort ];
        reshaped_var_list = UDF_reshape_var_from_dat(var_list);
        
        x          = reshaped_var_list(:,:,1);
        y          = reshaped_var_list(:,:,2);
        
        u          = reshaped_var_list(:,:,3);
        v          = reshaped_var_list(:,:,4);
        
        VelMagtd   = reshaped_var_list(:,:,5);
        vort       = reshaped_var_list(:,:,6);
        

%--------------------------------------------------------------------------
    
end


