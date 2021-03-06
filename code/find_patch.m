function [ out ]= find_patch(inp,im,b_size, o_size, i,j)
    [M,N,B]=size(im);
    best=[0,0];
    ret_size=size(inp);
    out=inp;
  if(i==1 && j==1)
        r1=randi([1,M+1-ret_size(1)],1,1);
        r2=randi([1,N+1-ret_size(2)],1,1);
        out=im(r1:r1+ret_size(1)-1,r2:r2+ret_size(2)-1,:);
    
    elseif(i>1 && j==1)
        min_error=intmax;
        %en1=min(size(inp,1),o_size(1));
        if (size(inp,1)>o_size(1))
        left_over1=inp(1:o_size(1),:,:);
         %for lx=1:M+1-ret_size(1)
            % for ly=1:N+1-ret_size(2)
             for count=1:4000
                lx=randi([1,M+1-ret_size(1)],1,1);
                ly=randi([1,N+1-ret_size(2)],1,1);
                left_over2=im(lx:lx+size(left_over1,1)-1,ly:ly+size(left_over1,2)-1,:);
                 error=sum(sum(sum((left_over2-left_over1).^2)));
                 if error < min_error
                     min_error=error;
                     best=[lx,ly];
                 end
             end
            %end
         %end
         left_over1=inp(1:o_size(1),:,:);
         tmp=im(best(1):best(1)+ret_size(1)-1,best(2):best(2)+ret_size(2)-1,:);
         out=find_left_cut(tmp,left_over1);
        end
    elseif(i==1 && j>1)
         %en2=min(size(inp,2),o_size(2));
         if (size(inp,2)>=o_size(2))
         top_over1=inp(:,1:o_size(2),:);
         min_error=intmax;
         %for lx=1:M+1-ret_size(1)
            % for ly=1:N+1-ret_size(2)
            for count=1:4000
                lx=randi([1,M+1-ret_size(1)],1,1);
                ly=randi([1,N+1-ret_size(2)],1,1);
        
                top_over2=im(lx:lx+size(top_over1,1)-1,ly:ly+size(top_over1,2)-1,:);
                 error=sum(sum(sum((top_over2-top_over1).^2)));
                 if error < min_error
                     min_error=error;
                     best=[lx,ly];
                 end
          end
        %end
        %end
          top_over1=inp(:,1:o_size(2),:);
         tmp=im(best(1):best(1)+ret_size(1)-1,best(2):best(2)+ret_size(2)-1,:);
         out=find_top_cut(tmp,top_over1);
         end
    else
      %  en2=min(size(inp,2),o_size(2));
       %  en1=min(size(inp,1),o_size(1));
         if (size(inp,2)>o_size(2))
             if(size(inp,1)>o_size(1))
       top_over1=inp(:,1:o_size(2),:);
       left_over1=inp(1:o_size(1),:,:);
       min_error=intmax;
         %for lx=1:M+1-ret_size(1)
             %for ly=1:N+1-ret_size(2)
             for count=1:4000 
                lx=randi([1,M+1-ret_size(1)],1,1);
                 ly=randi([1,N+1-ret_size(2)],1,1);
        
                 top_over2=im(lx:lx+size(top_over1,1)-1,ly:ly+size(top_over1,2)-1,:);
                 left_over2=im(lx:lx+size(left_over1,1)-1,ly:ly+size(left_over1,2)-1,:);
                
                 error1=sum(sum(sum((top_over2-top_over1).^2)));
                 error2=sum(sum(sum((left_over2-left_over1).^2)));
                 error=error1+error2;
                 if error < min_error
                     
                     min_error=error;
                     best=[lx,ly];
                 end
             end
             %    end
         %end
         tmp=im(best(1):best(1)+ret_size(1)-1,best(2):best(2)+ret_size(2)-1,:);
        top_over1=inp(:,1:o_size(2),:);
       left_over1=inp(1:o_size(1),:,:);
       
         out=find_left_cut(tmp,left_over1);
         out=find_top_cut(out,top_over1);
             end
         end
    end
     
