function [Gradx,Grady] = normal2gradient(A,m)
% A = randn(20,20,3);
% B = randi([0, 1], [1, 1200]);
% B = reshape(B,[20,20,3]);
% % Created a pseudo matrix with surface normals and missing values
% A= A.*B;
%Performing the padding
 C = padarray(A,[1 1],0,'both');
for k = 1:size(C,3)
    for i =2:size(C,1)-1
        for j=2:size(C,2)-1
            if C(i,j,k)==0
                C(i,j,k)= 0.25*(C(i+1,j,k)+C(i-1,j,k)+C(i,j+1,k)+C(i,j-1,k));
            end
        end
    end
end
A= C(2:size(C,1)-1,2:size(C,2)-1,:);
Grady = zeros(size(A,1),size(A,2));
Gradx = zeros(size(A,1),size(A,2));
for i =1:size(A,1)
     for j=1:size(A,2)
         Grady(i,j)= A(i,j,2)/A(i,j,3);% taking gradient in y direction by taking norm of the difference between each component of normal
         Gradx(i,j)= A(i,j,1)/A(i,j,3);% taking gradient in x direction by taking norm of the difference between each component of normal
     end
end
%dzdy = Grady(2:size(C,1)-1,2:size(C,2)-1); 
%dzdx = Gradx(2:size(C,1)-1,2:size(C,2)-1); 
Grady = Grady.*double(m);
Gradx = Gradx.*double(m);


end