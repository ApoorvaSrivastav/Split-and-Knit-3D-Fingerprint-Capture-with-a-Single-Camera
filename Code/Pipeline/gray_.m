function gray_(path)
C = imbinarize(imread(strcat(path,'White/mask_c.jpg')));
% BW = imbinarize(BW);
% mask = imbinarize(remove_noise(BW));
% C = imfill(mask,'holes');
% imwrite(C,strcat(path,'White/mask.jpg'));
% imwrite(C,strcat(path,'IR/mask.jpg'));
for i =0:6
im1 = imread(strcat(path,'White/A.',num2str(i),'.jpg'));
im1 = im1.*uint8(C);
im1 = rgb2gray(im1);
% [R,G,B] = imsplit(im);
% im1= 0.1*R + 0.175*B +0.725*G;
im3 = cat(3,im1,im1,im1);
imwrite(im3,strcat(path,'White/B.',num2str(i),'.jpg'));
% imwrite(im2,strcat(path,folder,'/F.',num2str(i),'.jpg'));
% im2 = imread(strcat(path,'IR/',num2str(i),'.jpg'));
% im2 = im2.*uint8(C);
% imwrite(im2,strcat(path,'IR/A.',num2str(i),'.jpg'));
end
end