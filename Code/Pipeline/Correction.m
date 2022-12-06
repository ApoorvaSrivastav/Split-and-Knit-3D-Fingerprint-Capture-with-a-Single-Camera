function I_proper = Correction(I,J_thresh,pos)
% flag=0;

     I = imbinarize(I);
     mask = uint8(imsubtract(I,J_thresh)).*uint8(I);
     mask=mask*255;
     mask = imgaussfilt(mask,9);
     mask = adapthisteq(mask);
     mask = imbinarize(mask,'adaptive','Sensitivity',0.1);
% while flag~=1    
    st = regionprops(mask, 'BoundingBox');
%     disp(length(st));
    if length(st) ==1
        flag = one_box(st(1).BoundingBox,I);
%         disp(flag);
        if flag ==1
            I_proper =I;
        else
            I_proper = cut_thresh(I,J_thresh,pos);
            flag=1;
        end   
    else
             [flag,I_proper] = n_box(st,I,J_thresh,pos);
             if flag==0
                 [flag,I_proper] = segment(st,I,J_thresh);
%              disp(flag);
             end

    end
% end
     
end
