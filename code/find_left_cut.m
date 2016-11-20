function [ out ]= find_left_cut(image,overlap)
    overlap1=image(1:size(overlap,1),:,:);
    surface=(overlap-overlap1).^2;
    surf=double(surface(:,:,1)+surface(:,:,2)+surface(:,:,3));
    cost=double(zeros(size(surf)));
    cost(:,1)=surf(:,1);
    for i=2:size(cost,2)
        for j=1:size(cost,1)
            if(j>1 && j<size(cost,1))
                cost(j,i)=surf(j,i)+min([cost(j-1,i-1),cost(j,i-1),cost(j+1,i-1)]);
            elseif(j==1)
                cost(j,i)=surf(j,i)+min([cost(j,i-1),cost(j+1,i-1)]);
            elseif(j==size(cost,1))
                cost(j,i)=surf(j,i)+min([cost(j-1,i-1),cost(j,i-1)]);
            end
        end
    end

    border=zeros(size(cost,2));
    border=border+1;
    n=size(border);
    min_cost=min(cost(:,n));
    for j=1:size(cost,1)
        if(cost(j,n)==min_cost(1))
            border(n)=j;
        end
   end
   for i=n-1:-1:1
      min_cost=min_cost-surf(border(i+1),i+1);
      if(min_cost==cost(border(i+1),i))
          border(i)=border(i+1);
        end
       if(border(i+1)>1)
            if min_cost==cost(border(i+1)-1,i)
                border(i)=border(i+1)-1;
            end
        end
        if(border(i+1)<size(cost,1))
            if min_cost==cost(border(i+1)+1,i) 
                border(i)=border(i+1)+1;
            end
        end
    end
    
    for i=1:n
        image(1:border(i),i)=overlap(1:border(i),i);
    end   
    out=image;