function crop(path,type)
if type==1
    mask_im = imread(strcat(path,'White/','F.mask1_.jpg'));
    mask_im = imbinarize(mask_im);
    pos = autocrop(mask_im);   
    %disp(pos);
    for i =0:6
        A = imread(strcat(path,'White/C.',num2str(i),'.jpg'));
        crop_F = imcrop(A,pos); %[936,1528,3]
        imwrite(crop_F,strcat(path,'White/D.',num2str(i),'.jpg'));
    end
    crop_F = imcrop(mask_im,pos); %[936,1528,3]
    imwrite(crop_F,strcat(path,'White/F.mask1.jpg'));
%     imwrite(crop_F,strcat('./Mask/',id,num2str(num),'_3.jpg'));
    A =255*ones(size(crop_F));
    imwrite(A,strcat(path,'White/F.mask.jpg'));
 
else
    mask_im = imread(strcat(path,'IR/','F.mask1_.jpg'));
    mask_im = imbinarize(mask_im);
    pos = autocrop(mask_im);   
    for i =0:6
        A = imread(strcat(path,'IR/C.',num2str(i),'.jpg'));
        crop_F = imcrop(A,pos); %[936,1528,3]
        imwrite(crop_F,strcat(path,'IR/F.',num2str(i),'.jpg'));    
    end
    crop_F = imcrop(mask_im,pos); %[936,1528,3]
    imwrite(crop_F,strcat(path,'IR/F.mask1.jpg'));
    A =255*ones(size(crop_F));
    imwrite(A,strcat(path,'IR/F.mask.jpg'));

end
end



