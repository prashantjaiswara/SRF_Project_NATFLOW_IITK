function PathOfFile = UDF_FindFile( path, keyword, ext)

ext=lower(ext);

if ext(1) ~= '.'
    ext = char( strcat('.',ext) );
end

ext = strcat('*',ext);

dir_list = dir( fullfile(path,ext) );

PathOfFile=[];
if ~isempty( dir_list )
    File_list = string(extractfield( dir( fullfile(path,ext) ), 'name' ) )';
    
    for i_File_list = 1 :1: length(File_list)
        if contains(File_list(i_File_list),keyword)
            PathOfFile = [PathOfFile;...
                fullfile( path, File_list(i_File_list) ) ];
        end
        
    end
        
else 
    disp('File not found. Please check the path, filename and extension.');
    UDF_Pronounce('File not found. Please check the path, filename and extension.');
end

if isempty(PathOfFile)
    disp('File not found. Please check the path, filename and extension.');
    UDF_Pronounce('File not found. Please check the path, filename and extension.');
end
    

end
