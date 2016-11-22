myNumOfColors = 250;
myColorScale = [ [0:1/(myNumOfColors-1):1]' ,[0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]' ];


im=imread('../data/textures/text.jpg');
trans=imread('../data/specimen/obama.jpg');
im=im2double(im);
trans=im2double(trans);
[l,h,b] = size(im);
b_size=[30,30];
o_size=[6,6];
out_size=[l*2,h*2,b];
out_image=quilt_synthesize(b_size,o_size,im,out_size);

figure(1);
subplot(1,2,1), imagesc(out_image);
colormap (myColorScale);
title 'Quilted Texture'
daspect ([1 1 1]);
axis tight
subplot(1,2,2), imagesc(im);
colormap (myColorScale);
title 'Original texture'
daspect ([1 1 1]);
axis tight

b_size=[25,25];
alpha=0.7;
fin_image=quilt_transfer(trans,b_size,o_size,im,alpha);

figure(2);
subplot(1,3,1), imagesc(fin_image);
colormap (myColorScale);
title 'Textured Transfer Image'
daspect ([1 1 1]);
axis tight

subplot(1,3,2), imagesc(trans);
colormap (myColorScale);
title 'Target Image'
daspect ([1 1 1]);
axis tight

subplot(1,3,3), imagesc(im);
colormap (myColorScale);
title 'Texture'
daspect ([1 1 1]);
axis tight