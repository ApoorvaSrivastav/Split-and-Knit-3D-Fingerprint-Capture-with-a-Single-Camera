sess =1;
num_db = 210;
num_q = 105;
% start_q = (id-1)*20+1;
% end_q =start_q+num_q-1;
% id =7;
% start_q = 151;
% end_q = 190;
% disp(start_q);
% disp(end_q);
score = double(zeros(210,210,2));

for i=1:num_db
for j=1:num_q
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

        score(i,j,1) = match_normal(db_normal,aligned_normal_q,15); %Fingerprint normal match
        score(i,j,2)= match_normal(db_IR_normal,aligned_IR_normal_q,4); %Fingershape Similarity 
%        break 
end
% break
end
name = strcat('./Results/Score',num2str(num_db),'_',num2str(num_q),'_session',num2str(sess),'.mat');
save(name,'score');