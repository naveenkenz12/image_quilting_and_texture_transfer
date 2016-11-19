function [ out ]= find_patch(inp,im,b_size, o_size, i,j)
    [M,N,B]=size(im);
    best=[0,0];
    min_error=intmax;
    if(i==1 && j==1)
        r1=randi([1,M+1-b_size(1)],1,1);
        r2=randi([1,N+1-b_size(2)],1,1);
        out=im(r1:r1+b_size(1)-1,r2:r2+b_size(2)-1,:);
    
    elseif(i>1 && j==1)
        min_error=intmax;
        en1=min(size(inp,1),o_size(1));
         left_over1=inp(1:en1,:,:);
         for lx=1:M+1-b_size(1)
             for ly=1:N+1-b_size(2)
                 left_over2=im(lx:lx+size(left_over1,1)-1,ly:ly+size(left_over1,2)-1,:);
                 error=(sum(sum(sum((left_over2-left_over1).^2))))/(size(left_over1,1)*size(left_over1,2)*size(left_over1,3));
                 if error < min_error
                     lx
                     ly
                     error
                     min_error=error;
                     best=[lx,ly];
                     
                 end
            end
         end
         min_error
         out=im(best(1):best(1)+b_size(1)-1,best(2):best(2)+b_size(2)-1,:);
    
    elseif(i==1 && j>1)
         en2=min(size(inp,2),o_size(2));
         top_over1=inp(:,1:en2,:);
         min_error=intmax;
         for lx=1:M+1-b_size(1)
             for ly=1:N+1-b_size(2)
                 top_over2=im(lx:lx+size(top_over1,1)-1,ly:ly+size(top_over1,2)-1,:);
                 error=(sum(sum(sum((top_over2-top_over1).^2))))/(size(top_over1,1)*size(top_over1,2)*size(top_over1,3));
                 if error < min_error
                     lx
                     ly
                     error
                     min_error=error;
                     best=[lx,ly];
                 end
            end
         end
         min_error
         out=im(best(1):best(1)+b_size(1)-1,best(2):best(2)+b_size(2)-1,:);
    
    else
        en2=min(size(inp,2),o_size(2));
         en1=min(size(inp,1),o_size(1));
         
       top_over1=inp(:,1:en2,:);
       left_over1=inp(1:en1,:,:);
       min_error=intmax;
         for lx=1:M+1-b_size(1)
             for ly=1:N+1-b_size(2)
                 top_over2=im(lx:lx+size(top_over1,1)-1,ly:ly+size(top_over1,2)-1,:);
                 left_over2=im(lx:lx+size(left_over1,1)-1,ly:ly+size(left_over1,2)-1,:);
                
                 error1=(sum(sum(sum((top_over2-top_over1).^2))))/(size(top_over1,1)*size(top_over1,2)*size(top_over1,3));
                 error2=(sum(sum(sum((left_over2-left_over1).^2))))/(size(left_over1,1)*size(left_over1,2)*size(left_over1,3));
                 error=error1+error2;
                 if error < min_error
                     lx
                     ly
                     error
                     min_error=error;
                     best=[lx,ly];
                 end
            end
         end
         min_error
         out=im(best(1):best(1)+b_size(1)-1,best(2):best(2)+b_size(2)-1,:);
    
    end
     
