function Phalange(path)
    I = imread(strcat(path,'White/mask_c.jpg'));
    I_mask = imbinarize(I);
    [M,N]= size(I);
    J = uint16(zeros(M,N,3));
    for i =0:6
        J = J + uint16(imread(strcat(path,'White/B.',string(i),'.jpg')));
    end
    J = J -uint16(imread(strcat(path,'White/B.5.jpg')));
    J = J/6;

    J = uint8(J).*uint8(I_mask);

    %Obtaining threshold image for vein
    %-----------------------------------
    J_gray= rgb2gray(J);
    J_gray = imgaussfilt(J_gray,7);
    J_c =255-J_gray;
    J_c =imadjust(imadjust(imadjust(imadjust(imadjust(J_c)))));
    J_c = uint8(J_c).*uint8(I_mask);
    J_thresh = imbinarize(J_c,'adaptive');
%     figure,imshow(J_thresh);
    % Obtaining segmentation
    % ------------------
    s = regionprops(J_thresh,'BoundingBox');
    s = struct2cell(s);
    boxes = cell2mat(s);
    boxes = reshape(boxes,4,size(s,2));
    area = boxes(3,:).*boxes(4,:);
    [~,index] = max(area,[],'linear');
    pos = boxes(:,index);

    start = uint16(pos(2))+uint16(0.25*pos(4));
    num2 =10000;
    for i =start:uint16(size(I,1)*0.95)
        A= J_thresh(i,:);
        num1= numel(A)-nnz(A);
        if num1<num2
           num2 =num1;
           ph=i;
        end
    end
    I(ph:size(I,1),:)=0;
    I_proper = Correction(I,J_thresh,pos);
    %I_proper=imbinarize(I);
% % %     disp(flag);
% %     list_c = [list_c;[num,flag]];
%    I_proper = imread('./db/116/White/F.mask1_.jpg');
% %     figure, imshow(I_proper), title('After Approval');
    
%     figure,imshow(I);
    % imwrite(I,strcat(num2str(k),'seg.jpg'));
    imwrite(I_proper,strcat(path,'IR/F.mask1_.jpg'));
    imwrite(I_proper,strcat(path,'White/F.mask1_.jpg'));
%     imwrite(J_thresh,strcat('./Mask/',id,num2str(num),'_1.5.jpg'))
%     imwrite(I,strcat('./Mask/',id,num2str(num),'_2.jpg'))
%     
    for i =0:6
        im2 = imread(strcat(path,'IR/A.',string(i),'.jpg'));
        im2 =im2.*uint8(cat(3,I_proper,I_proper,I_proper));
        imwrite(im2,strcat(path,'IR/C.',string(i),'.jpg'));    
        im2 = imread(strcat(path,'White/A.',string(i),'.jpg'));
        im2 =im2.*uint8(cat(3,I_proper,I_proper,I_proper));
        imwrite(im2,strcat(path,'White/C.',string(i),'.jpg'));   
    end

end