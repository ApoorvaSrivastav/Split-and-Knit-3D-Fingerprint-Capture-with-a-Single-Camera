function ptCloud = pCloud(z,mask)
%function to create matlab point cloud object
    x=size(z,1);
    y=size(z,2);
    mask=imbinarize(mask);
    num =nnz(mask);
    ptCloud=zeros(num,3);
    k=1;
    for i =1:x
        for j=1:y
            if mask(i,j)~=0
            ptCloud(k,1)=i;
            ptCloud(k,2)=j;
            ptCloud(k,3)=z(i,j);
            k=k+1;
            end
        end
    end
    ptCloud = pointCloud(ptCloud);
end
