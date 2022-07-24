clc
clear all
close all

basepath = 'C:\Users\91935\OneDrive - IIT Kanpur\Natflow_Hari\PIV\PIV_2022-05-17\5_Trail_Codes_with_files';

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



function PathOfLargestMATfile = FindLargestMATFile( basepath )

    PathOfFile = UDF_FindFile( basepath, '', '.mat');
    SizeOfFile = zeros( length(PathOfFile),1 );

    for i=1:1:length( PathOfFile )
        SizeOfFile(i) = dir( PathOfFile(i) ).bytes;
    end

    index_of_largest_MATfile = find( SizeOfFile == max( SizeOfFile ) );
    PathOfLargestMATfile   = PathOfFile( index_of_largest_MATfile );

end