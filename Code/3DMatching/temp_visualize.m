Mat  = load('./score_normal_3to4_GC_HOG.mat','score');
S2to4 =Mat.score;
 A = S2to4;%fp
% B = S2to4(:,:,2);
% disp(nnz(A));
 A = A(A~=0);
 A =reshape(A,170,170);
% B = B(B~=0);
% B =reshape(B,170,170);
% C =cat(3,A,B);
% save('3to4.mat','C');
Col_norm_Score = zeros(170,170);
% Col_norm_Score = zeros(210,210,3);
% for i=1:2
    for j=1:170
%       Col_norm_Score(:,j,i)=normalize(C(:,j,i),'range');
        Col_norm_Score(:,j)=normalize(A(:,j),'range');
    end
% end
% Col_norm_Score(:,:,3) = 0.7*Col_norm_Score(:,:,1) + 0.3*Col_norm_Score(:,:,2);
% save('Norm3to4.mat','Col_norm_Score');
% D = Col_norm_Score(:,:,1);
% E = Col_norm_Score(:,:,2);
% F = Col_norm_Score(:,:,3);
Metrics_single(Col_norm_Score,170,1000);
