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
MatFilePath = fullfile( basepath, '3_Processed_Files', 'MATFiles');

%--------------------------------------------------------------------------

PathOfFile = UDF_FindFile( SetInfoPath, 'Master_SetInfo_c05', '*');

[p_x_img , p_y_img , Total_Pixel_X , Total_Pixel_Y ,mm_per_pixel , Case_list,...
    ImageFileNameList_with_theta, theta_list_across_AxFy ]...
    = UDF_get_NACA_Info(PathOfFile,'');

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
    total_no_of_AxFy = 12;
    
    for i_AxFy = 12 :1: total_no_of_AxFy
        
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

            disp(current_Run_path);
            
            PathOf_x_y_grid_File = UDF_FindFile( current_Run_path, 'x_y_grid', '*');

            
            load( PathOf_x_y_grid_File );
            
            x = ( x0 - ( p_x_img * mm_per_pixel -15) )/50 ;
            y = ( y0 -   p_y_img * mm_per_pixel      )/50 ;
            
            for i_mat =101:2:111
                
                MatFilename = ls(fullfile(current_Run_path, strcat('*',int2str(i_mat),'.mat')));
                
                load( fullfile( current_Run_path, MatFilename ) );
                rarity = 2;
                
                figure(i_mat)
                hold on
                quiver(x(1:rarity:end,1:rarity:end),y(1:rarity:end,1:rarity:end),...
                    u(1:rarity:end,1:rarity:end),v(1:rarity:end,1:rarity:end),3,'b');
                plot(0,0,'*k');
                
                %------------------------------------------------------------------
                
                xaxis_min_lim = -0.5;
                xaxis_max_lim = +7.5;
                yaxis_min_lim = -2.5;
                yaxis_max_lim = +2.5;
                
                axis( [xaxis_min_lim xaxis_max_lim  yaxis_min_lim yaxis_max_lim] );
                pbaspect([(xaxis_max_lim - xaxis_min_lim),...
                    (yaxis_max_lim - yaxis_min_lim), 1])
                
                
                hold on
                xticks( xaxis_min_lim+0.5 :1: xaxis_max_lim-0.5);
                xlabel('x/c');
                
                yticks(yaxis_min_lim+0.5 :1: yaxis_max_lim-0.5);
                ylabel('y/c');
                
                %     title('c1A10F1');
                
                ax = gca;
                ax.TickDir = 'out';
                ax.TickLength = [0.01 0.01];
                ax.FontSize = 15;
                set(gca,'box','on')
                
                %                 % grid on;
                hold on
                %
                h1= line([min(x(1,:)),max(x(1,:))],[ 0, 0 ] );
                h2= line( [ 0, 0 ], [min(y(:,1)),max(y(:,1))] );

                h1.LineStyle = '-.';
                h1.Color = 'k';
                
                h2.LineStyle = '-.';
                h2.Color = 'k';
                
                hold off
                
            end
            
            
            
            
            %------------------------------------------------------------------

            
        end
        
    end

end


