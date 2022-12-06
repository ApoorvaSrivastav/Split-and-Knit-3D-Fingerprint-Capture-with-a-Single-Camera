function [flag,I_proper] = n_box(st,I,J_thresh,pos)
I_proper =I;
len = length(st);
boxes = zeros(len,5);
for i=1:len
    boxes(i,1:4) = st(i).BoundingBox;
end

boxes(:,5) = boxes(:,3).*boxes(:,4);
vec = boxes(:,5);
[vec,idx] = sort(vec,'descend');

boxes_sorted = boxes(idx,:);

% disp(boxes_sorted);
A = boxes_sorted(1,1:4);
B = boxes_sorted(2,1:4);
% disp(A);
overlapRatio = double(bboxOverlapRatio(A,B));
% disp(vec(2)/vec(1)>0.3);
% disp(overlapRatio<0.1);
% disp(uint16(abs(A(2)+A(4)-B(2))/10)<10 || uint16(abs(B(2)+B(4)-A(2))/10)<10);
if ((vec(2)/vec(1))>0.3) && (overlapRatio<0.1) && (uint16(abs(A(2)+A(4)-B(2))/10)<10 || uint16(abs(B(2)+B(4)-A(2))/10)<10)% case when there are comparable bbox one over other and non-overlapping meaning that segmentation is needed
      flag = 0;% needs segmentation
elseif vec(2)/vec(1)<=0.3 ||  ((vec(2)/vec(1))>0.3) && ((overlapRatio>0.1) || (uint16(abs(A(2)+A(4)-B(2))/10)>10 || uint16(abs(B(2)+B(4)-A(2))/10)>10))           %case when the bbox were big but not one above the other so no segmentation needed
    flag = one_box(A,I); % check if its proper
    if flag==0
       I_proper = cut_thresh(I,J_thresh,pos);
       flag=1;
    end
else 
     flag=1;
end
%disp(flag);        

end