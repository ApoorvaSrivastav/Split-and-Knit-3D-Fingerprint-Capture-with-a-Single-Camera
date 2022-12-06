function pos = bbox(BW)
s = regionprops(BW,'BoundingBox');
s = struct2cell(s);
boxes = cell2mat(s);
boxes = reshape(boxes,4,size(s,2));
area = boxes(3,:).*boxes(4,:);
[~,index] = max(area,[],'linear');
pos = boxes(:,index);
% [e1,e2] = s(:).Extent;
% [~,index] = max([e1,e2],[],'linear');
% pos = s(index).BoundingBox;
% disp(index);
% disp(s(1).Extent);
% disp(s(2).Extent);
% disp(s(1).BoundingBox);
% disp(s(2).BoundingBox);
end