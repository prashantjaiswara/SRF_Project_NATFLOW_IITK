function reshaped_var_list= UDF_reshape_var_from_dat(var_list)

            var=var_list(:,1);

            h=length(find( var == var(1) ) );  %rows
            w=length(var)/h;                   %columns   

            len=length(var_list(1,:));
            reshaped_var_list=zeros(h,w,len);

            for i=1:1:len
                reshaped_var_list(:,:,i)= reshape_var(  var_list(:,i),h,w  );        
            end
          
end

function var= reshape_var(var,h,w)                      
        
    var=reshape(var,[w,h])';  

end

