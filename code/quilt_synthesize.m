function [ out_image ]= quilt_synthesize(b_size,o_size,im,out_size)
out_image=double(zeros(out_size));
for i=1:b_size(1)-o_size(1):out_size(1)
    left=min(i+b_size(1)-1,out_size(1));
    for j=1:b_size(2)-o_size(2):out_size(2)
        bottom=min(j+b_size(2)-1,out_size(2));
        tmp = find_patch(out_image(i:left,j:bottom,:),im,b_size,o_size,i,j);
        out_image(i:left,j:bottom,:)=tmp(1:left+1-i,1:bottom+1-j,:);
    end
    
end
