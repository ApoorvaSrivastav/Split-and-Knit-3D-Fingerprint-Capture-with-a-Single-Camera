session = '3to4_2450_210';
overlap_score = zeros(210,210);
shape_context_score = zeros(210,210);
for i=24:50
for j=1:210
if (i>70 &&i<=80)||(i>170 &&i<=180)||(i>90 &&i<=100)||(i>190 &&i<=200)||(j>70 &&j<=80)||(j>170 &&j<=180)||(j>90 &&j<=100)||(j>190 &&j<=200)
     continue
 else
    q_mask = imread(strcat('./Results/query2_',num2str(j),'_mask.jpg'));
    db_mask = imread(strcat('./Results/db2_',num2str(i),'_mask.jpg'));
        
    q_mask = imbinarize(q_mask);
    db_mask = imbinarize(db_mask);
    disp(j);
    aligned_q_mask = Align(q_mask,db_mask);

    overlap = and(db_mask,aligned_q_mask);
    %overlap_score(i,j) = 2*nnz(overlap)/(nnz(db_mask)+nnz(db_mask));
    shape_context_score(i,j) = match_mask_shapecontext(db_mask,aligned_q_mask,gap);
%     break
 end
end
% break
end

% name = strcat('./Results/Overlap_score',session,'.mat');
% save(name,'overlap_score');
name = strcat('./Results/ShapeContext_score',session,'.mat');
save(name,'shape_context_score');