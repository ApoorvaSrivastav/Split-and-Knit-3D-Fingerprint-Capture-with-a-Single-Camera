function [flag,I_new] = segment(st,I,J_thresh)
    len = length(st);
    vec = zeros(len,1);
    boxes = zeros(len,4);
    %disp(size(boxes));
    if len==1
        I_new = I;
        flag =0;
    elseif len>=2
        for i=1:len
            vec(i) = st(i).BoundingBox(1,3).*st(i).BoundingBox(1,4);
            %disp(size(st(i).BoundingBox));
            boxes(i,:) = st(i).BoundingBox;
        end
        [vec,idx] = sort(vec,'descend');
        B_new = boxes(idx,:);
        A = B_new(1,:);
        B = B_new(2,:);
        overlapRatio = bboxOverlapRatio(A,B);
        if vec(2)/vec(1)>0.3 && overlapRatio<0.1 && (uint16(abs(A(2)+A(4)-B(2))/10)<10 || uint16(abs(B(2)+B(4)-A(2))/10)<10)
            if A(2)<B(2)
            start = uint16(min(A(2)+A(4),B(2)));
            stop = uint16(max(A(2)+A(4),B(2)));
            else
            start = uint16(min(B(2)+B(4),A(2)));
            stop = uint16(max(B(2)+B(4),A(2)));
            end
            num2 =10000;
            for i =start:stop
                A= J_thresh(i,:);
                num1= numel(A)-nnz(A);
                if num1<num2
                   num2 =num1;
                   ph=i;
                end
            end
            I(ph:size(I,1),:)=0;
            I_new =I;
            flag =1;
        else
            flag =0;
            I_new = I;
        end

    end
        


end