function [ out ]= find_top_cut(image,overlap)
    overlap1=image(:,1:size(overlap,2),:);
    surface=(overlap-overlap1).^2;
    surf=double(surface(:,:,1)+surface(:,:,2)+surface(:,:,3));
    cost=double(zeros(size(surf)));
    cost(1,:)=surf(1,:);
    for i=2:size(cost,1)
        for j=1:size(cost,2)
            if(j>1 && j<size(cost,2))
                cost(i,j)=surf(i,j)+min([cost(i-1,j-1),cost(i-1,j),cost(i-1,j+1)]);
            elseif(j==1)
                cost(i,j)=surf(i,j)+min([cost(i-1,j),cost(i-1,j+1)]);
            elseif(j==size(cost,2))
                cost(i,j)=surf(i,j)+min([cost(i-1,j-1),cost(i-1,j)]);
            end
        end
    end

    border=zeros(size(cost,1));
    border=border+1;
    n=size(border);
    min_cost=min(cost(n,:));
    for j=1:size(cost,2)
        if cost(n,j)==min_cost(1)
            border(n)=j;
        end
    end
    for i=n-1:-1:1
        min_cost=min_cost-surf(i+1,border(i+1));
        if(min_cost==cost(i,border(i+1)))
            border(i)=border(i+1);
        end
        if(border(i+1)>1)
            if min_cost==cost(i,border(i+1)-1)
                border(i)=border(i+1)-1;
            end
        end
        if(border(i+1)<size(cost,2))
            if min_cost==cost(i,border(i+1)+1)
                border(i)=border(i+1)+1;
            end
        end
    end
    
    for i=1:n
        image(i,1:border(i),:)=overlap(i,1:border(i),:);
    end    
    out=image;