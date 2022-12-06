function clean(path)
I = imread(strcat(path,'/White/mask1.jpg'));
% imwrite(I,strcat('./Mask/',id,num2str(num),'.jpg'));
mask = imfill(I,'holes');
[C1,angle1] = rotate_clean(mask);
[C2,angle2] = rotate_clean(C1);
angle = angle1+angle2;
%[C2,angle] = rotate_clean(mask);


imwrite(C2,strcat(path,'/White/mask_c.jpg'));
imwrite(C2,strcat(path,'/IR/mask_c.jpg'));
% imwrite(C,strcat('./Mask/',id,num2str(num),'_1.jpg'))

for i =1:7
    img = imread(strcat(path,'/White/',num2str(i-1),'.jpg'));
    J = imrotate(img,-angle,'crop');
    J = J.*uint8(imbinarize(C2));
    imwrite(J,strcat(path,'/White/A.',num2str(i-1),'.jpg'));
    img2 = imread(strcat(path,'/IR/',num2str(i-1),'.jpg'));
    J2 = imrotate(img2,-angle,'crop');
    J2 = J2.*uint8(imbinarize(C2));
    imwrite(J2,strcat(path,'/IR/A.',num2str(i-1),'.jpg'));
end 

end