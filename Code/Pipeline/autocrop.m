function pos = autocrop(BW)

%figure,imshow(C);
s = regionprops(BW,'BoundingBox');
s = struct2cell(s);
boxes = cell2mat(s);
boxes = reshape(boxes,4,size(s,2));
area = boxes(3,:).*boxes(4,:);
[~,index] = max(area,[],'linear');
pos = boxes(:,index);
centerx = pos(1) + uint32(pos(3)/2);
centery = pos(2) + uint32(pos(4)/2);
% disp(pos);
% disp(centerx);
 %disp(centery-764);
a =pos(1);
b =pos(2);
% disp(pos(2));
pos(1) = centerx - 468;%(936/2)
pos(2) = centery - 764;%(1527/2)(1488/2)
% if pos(2)>b
%   pos(2) = b-100;
% end
%  disp(pos(2));
% disp(pos(2) + 1527);
if pos(2) + 1527 > 2200
   pos(2) = pos(2) - (1527+ pos(2)-2200);
   %disp('yo');
end
if centery - 764<=0
    pos(2)=1;
    %disp('yo');
end
%disp(pos(2));    
pos(3) =935;
pos(4) =1527;
% imshow(C);
% hold on
% rectangle('Position', pos,...
%   'EdgeColor','r', 'LineWidth', 3)
%C= imcrop(C,pos);
end