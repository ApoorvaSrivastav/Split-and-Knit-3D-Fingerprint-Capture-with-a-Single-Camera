function start = start_locate(C)
s = regionprops(C,'BoundingBox');
s = struct2cell(s);
boxes = cell2mat(s);
boxes = reshape(boxes,4,size(s,2));
area = boxes(3,:).*boxes(4,:);
[~,index] = max(area,[],'linear');
pos = boxes(:,index);
start = int16([pos(1),pos(2)]);
end