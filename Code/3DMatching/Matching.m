% id =5;
% num_db = 210;
% num_q = 20;
% start_q = (id-1)*20+1;
% end_q =start_q+num_q-1;
id =7;
start_q = 151;
end_q = 190;
disp(start_q);
disp(end_q);
score = double(zeros(num_db,num_q,3));


for i =1:num_db 
    for j=start_q:end_q
%  disp(i);
%  disp(j);
        % Reading the data for matching 
        q_mask = imread(strcat('./Results/query',num2str(j),'_mask.jpg'));
        db_mask = imread(strcat('./Results/db',num2str(i),'_mask.jpg'));
        
        q_mask = imbinarize(q_mask);
        db_mask = imbinarize(db_mask);
        
        Mat = load(strcat('./Results/query',num2str(j),'_IR.mat'));
        q_IR_normal =Mat.surfNormals;
        Mat = load(strcat('./Results/db',num2str(i),'_IR.mat'));
        db_IR_normal= Mat.surfNormals;

        Mat= load(strcat('./Results/query',num2str(j),'_White.mat'));
        q_normal= Mat.surfNormals;
        Mat = load(strcat('./Results/db',num2str(i),'_White.mat'));
        db_normal = Mat.surfNormals;
      
        [final_trans,aligned_q_mask] = Align(q_mask,db_mask); 
 
        aligned_normal_q = imtranslate(q_normal,final_trans,'FillValues',0,'OutputView','same');
        aligned_IR_normal_q = imtranslate(q_IR_normal,final_trans,'FillValues',0,'OutputView','same');

        %Score Calculation
        
        score(i,j,2) = match_fpnormal(db_normal,aligned_normal_q,db_mask,aligned_q_mask); %Surface normal match
        score(i,j,3) = match_shape_normal(db_IR_normal,aligned_IR_normal_q,db_mask,aligned_q_mask); %Cosine Similarity 
%        break 
    end
% break
disp(i);
end
score(:,:,1) = (score(:,:,2).*score(:,:,3))./(score(:,:,2)+score(:,:,3)); 
name = strcat('./Results/Score',num2str(num_db),'_',num2str(num_q),'_',num2str(id),'.mat');
save(name,'score');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Analysis

% name = strcat('./Results/FinalScore.mat');
% save(name,'SCORE');
% minmax_score = zeros(size(SCORE));
% Col_norm_Score = zeros(size(SCORE));
% 
% minmax_score(:,:,2) = (SCORE(:,:,2)-min(min(SCORE(:,:,2))))/(max(max(SCORE(:,:,2)))-min(min(SCORE(:,:,2))));
% minmax_score(:,:,3) = (SCORE(:,:,3)-min(min(SCORE(:,:,3))))/(max(max(SCORE(:,:,3)))-min(min(SCORE(:,:,3))));
% 
% 
% minmax_score(:,:,1) = (minmax_score(:,:,2).*minmax_score(:,:,3))./(minmax_score(:,:,2)+minmax_score(:,:,3)); 
% 
% 
% for i=1:3
%     for j=1:210
%       Col_norm_Score(:,j,i)=normalize(minmax_score(:,j,i),'range');
%     end
% end
% 
% Metrics(Col_norm_Score,210,1000);
