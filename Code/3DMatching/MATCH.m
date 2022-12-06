score = double(zeros(60,60,3));

num_threshold = 1000;
range = '1-60';
for i =1:60 
    for j=1:60
 
        % Reading the data for matching 
        q_mask = imread(strcat('./query/',num2str(j),'/White/F.mask1.jpg'));
        db_mask = imread(strcat('./db/',num2str(i),'/White/F.mask1.jpg'));
        
        q_mask = imbinarize(q_mask);
        db_mask = imbinarize(db_mask);
        
        Mat = load(strcat('./query/',num2str(j),'/IR/Results/normal.mat'));
        q_IR_normal =Mat.surfNormals;
        Mat = load(strcat('./db/',num2str(i),'/IR/Results/normal.mat'));
        db_IR_normal= Mat.surfNormals;

        Mat= load(strcat('./query/',num2str(j),'/White/Results/normal.mat'));
        q_normal= Mat.surfNormals;
        Mat = load(strcat('./db/',num2str(i),'/White/Results/normal.mat'));
        db_normal = Mat.surfNormals;
      
        [final_trans,aligned_q_mask] = Align(q_mask,db_mask); 
 
        aligned_normal_q = imtranslate(q_normal,final_trans,'FillValues',0,'OutputView','same');
        aligned_IR_normal_q = imtranslate(q_IR_normal,final_trans,'FillValues',0,'OutputView','same');

        %Score Calculation
        
        score(i,j,2) = match_fpnormal(db_normal,aligned_normal_q,db_mask,aligned_q_mask); %Surface normal match
        score(i,j,3) = match_shape_normal(db_IR_normal,aligned_IR_normal_q,db_mask,aligned_q_mask); %Cosine Similarity 
        
    end

end
score(:,:,1) = score(:,:,2).*score(:,:,3)./(score(:,:,2)+score(:,:,3)); 

minmax_score = zeros(size(score));
Col_norm_Score = zeros(size(score));

minmax_score(:,:,1) = (score(:,:,1)-min(min(score(:,:,1))))/(max(max(score(:,:,1)))-min(min(score(:,:,1))));
minmax_score(:,:,2) = (score(:,:,2)-min(min(score(:,:,2))))/(max(max(score(:,:,2)))-min(min(score(:,:,2))));
minmax_score(:,:,3) = (score(:,:,3)-min(min(score(:,:,3))))/(max(max(score(:,:,3)))-min(min(score(:,:,3))));

for i=1:3
    for j=1:60
      Col_norm_Score(:,j,i)=normalize(minmax_score(:,j,i),'range');
    end
end

save('Score.mat','score');
save('MinMax_score.mat','minmax_score');
save('Final_Norm.mat','Col_norm_Score');

Result_score  = Metrics(score,size(score,1),num_threshold);
save(strcat('Result_Score',range,'.mat'),'Result_score');
 
Result_MinMax_score  = Metrics(minmax_score,size(score,1),num_threshold);
save(strcat('Result_MinMax_score',range,'.mat'),'Result_MinMax_score');

Result_FinalNorm_score  = Metrics(Col_norm_Score,size(score,1),num_threshold);
save(strcat('Result_FinalNorm_score',range,'.mat'),'Result_FinalNorm_score');