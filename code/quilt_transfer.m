function [ fin_image ]= quilt_transfer(trans,b_size,o_size,im,alpha)
out_size=size(trans);
fin_image=double(zeros(out_size));

trans_ill=0.2126*trans(:,:,1)+0.7152*trans(:,:,2)+0.0722*trans(:,:,3);
im_ill=0.2126*im(:,:,1)+0.7152*im(:,:,2)+0.0722*im(:,:,3);
for i=1:b_size(1)-o_size(1):out_size(1)
    left=min(i+b_size(1)-1,out_size(1));
    for j=1:b_size(2)-o_size(2):out_size(2)
        bottom=min(j+b_size(2)-1,out_size(2));
        tmp = find_patch_transfer(fin_image(i:left,j:bottom,:),trans_ill(i:left,j:bottom),im,im_ill,b_size,o_size,i,j,alpha);
        fin_image(i:left,j:bottom,:)=tmp(1:left+1-i,1:bottom+1-j,:);
    end
end
