function [C,angle] = rotate_clean(mask)
BW1 = edge(mask,'Canny');
points = [];
for i =1:50:size(BW1,1)
    if nnz(BW1(i,:))~=0
        [~,idx,~]= find(BW1(i,:));
        thresh = 0.5*(idx(1,1)+ idx(1,size(idx,2)));
        m = imbinarize(idx,thresh);
        beginning = sum(double(1-m).*idx)/nnz(1-m);
        ending = sum(double(m).*idx)/nnz(m);
        j = 0.5*(beginning + ending);
        points = [points;i,j];
        
    end
end
coeffs = polyfit(points(:,1),points(:,2),1);
angle = rad2deg(atan(coeffs(1)));

K =imrotate(mask,-angle,'crop');
for j=1:size(K,2)
    vec= K(:,j);
    p = nnz(vec)/numel(vec);
    p = p*100;
    if p<10
        K(:,j)=0;
    end
end
C = remove_noise(K);
end