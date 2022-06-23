function dir_list= UDF_get_directories(path)
 
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
