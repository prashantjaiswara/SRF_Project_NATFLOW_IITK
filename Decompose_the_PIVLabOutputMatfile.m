clc
clear all
close all

basepath = 'C:\Users\91935\OneDrive - IIT Kanpur\Natflow_Hari\PIV\PIV_2022-05-17\5_Trail_Codes_with_files';
Filename = 'c30_A10F1_R1_S12I16.mat';

load( fullfile(basepath,Filename), 'x','y','u_original','v_original');

for i=1:1:5
    
    u = cell2mat(u_original(i) );
    v = cell2mat(v_original(i) );
    
    
    Filename_Prefix = 'c30_A10F1_R1_S12I16';
    
    if i>0 && i<10
        Filename_Suffix= strcat('00',string(i));
        
    elseif i>9 && i<100
        Filename_Suffix= strcat('0',string(i));
        
    elseif i>99 && i<1000
        Filename_Suffix= string(i);
        
    end

    FName = strcat( Filename_Prefix,'_',Filename_Suffix,'.mat');
    
    save(fullfile(basepath, FName),'u','v' );
    
end


