function point_cloud_generator(z,directory,imagename,ext)

ptCloud = pCloud(z);
pcwrite(ptCloud,strcat('./',directory,imagename,'/PointCloud',ext,'.ply'),'PLYFormat','ascii');
function [ptCloud] = pCloud(z)
    x=size(z,1);
    y=size(z,2);
    ptCloud=zeros(x*y,3);
    k=1;
    for i =1:x
        for j=1:y
            ptCloud(k,1)=i;
            ptCloud(k,2)=j;
            ptCloud(k,3)=z(i,j);
            k=k+1;
        end
    end
    ptCloud = pointCloud(ptCloud);
end
end
