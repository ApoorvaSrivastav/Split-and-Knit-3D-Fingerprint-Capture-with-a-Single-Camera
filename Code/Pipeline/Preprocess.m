function Preprocess(path)
    clean(path);
    gray_(path);% nothing to do with IR moreover it fills the mask and masks White &IR images to store as A
% %     won't be used%rotate_(path,i,id);% rotates the mask and images of only IR and name them as A_rot and mask_rot. It also rotates white images so that it can be used in Phalange Segmentation of IR
    Phalange(path);    
    crop(path,1);
    crop(path,0);
    CLAHE(1,path);
    for i =0:6
        Global_Direct(string(i),1,path)
    end
end