function I_proper = cut_thresh(I,J_thresh,pos)

             start = uint16(pos(2)+0.25*pos(4));
             stop = uint16(pos(2)+0.65*pos(4));
%              J = zeros(size(J_thresh));
%              J(start:stop,:) =J_thresh(start:stop,:);
%              figure,imshow(J);
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
             I_proper = I;
%              figure,imshow(I_proper);
    
end
