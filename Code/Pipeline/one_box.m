function flag = one_box(pos,I)
      aspect_ratio = pos(3)/pos(4);
      height =pos(4);
      start_row = pos(2)+pos(4);
%       disp(aspect_ratio);
%       disp(height<0.45*size(I,1));
%       disp(start_row<0.75*size(I,1));
      if aspect_ratio>0.4 || height<0.45*size(I,1) || start_row<0.75*size(I,1)
          flag = 1; %Its genuine
      else
          flag =0; %It needs further segmentation
      end
%         disp(flag);  
end