clc
clear all
close all

basepath = 'C:\Users\91935\OneDrive - IIT Kanpur\Natflow_Hari\PIV\PIV_2022-05-17';

list_of_folders = [...
    "0_Raw_data";...    
    "1_Processing_Parameters";...
    "2_Code";...
    "3_Processed_Files";...
    "4_Output";...
    "5_Trail_Codes_with_files";...
    "99_1_Trial_files"...
    ];
 
for i = 1 :1: length(list_of_folders)
    disp( UDF_check_and_make_folder(basepath, list_of_folders(i) ) );
end

%--------------------------------------------------------------------------
%---------------------------functions--------------------------------------
%--------------------------------------------------------------------------

function check=UDF_check_and_make_folder(baseFolder,Folder_name)
%Note: This function uses the following other User defined functions named:
% (1)  get_directories(arg1,..,..)

    dir_list=get_directories(baseFolder);
    check=find(dir_list(:,2)==string(Folder_name), 1);
    
    if (isempty(check))
        mkdir(baseFolder,Folder_name)
        str1=strcat("Folder named('",   Folder_name,   "') is created"   );
        %         str2=' inside the Parent Folder';
        %         str3=strcat(   " (",   baseFolder,   ")"   );
        check=str1;
        
    else
        str1=strcat(   "Folder named('",   Folder_name,   "') already exist"   );
        %         str2=' inside the Parent Folder';
        %         str3=strcat(   " (",   baseFolder,   ")"   );
        check=str1;
    end
   
        
end

function dir_list= get_directories(path)

 
 dir_content=dir(path);
 
 dir_index=find( [dir_content(:).isdir]== 1 );
 dir_index=dir_index(3:end);
 
 dir_list=strings(length(dir_index),2); %Creating empty string array to...
 % store Full path list (Column 1) and Immediate folder list (Column 2)
 
 
 
     for i=1:length(dir_index)
         dir_list(i,1)=fullfile(path, dir_content( dir_index(i)).name  );
         % Column 1 for Full path
         dir_list(i,2)=dir_content( dir_index(i)).name;         
         % Column 2 for Immediate Folders
     end
     

end

%--------------------------------------------------------------------------
%---------------------------end of functions-------------------------------
%--------------------------------------------------------------------------
        
