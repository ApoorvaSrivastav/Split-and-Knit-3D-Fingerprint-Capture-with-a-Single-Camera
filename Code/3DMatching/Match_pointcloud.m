sess='best';
% dotpr = double(zeros(210,210));
 h_score_HOG = double(zeros(210,210));
for i =1:210
    for j=1:210
        
        
 if (i>70 &&i<=80)||(i>170 &&i<=180)||(i>90 &&i<=100)||(i>190 &&i<=200)||(j>70 &&j<=80)||(j>170 &&j<=180)||(j>90 &&j<=100)||(j>190 &&j<=200)
     continue
 else
        % Reading the data for matching 
        q_mask = imread(strcat('./Case1/query2_',num2str(j),'_mask.jpg'));
        db_mask = imread(strcat('./Case1/db2_',num2str(i),'_mask.jpg'));
        
        q_mask = imbinarize(q_mask);
        db_mask = imbinarize(db_mask);
        

        Mat= load(strcat('./Case1/query2_',num2str(j),'_point.mat'));
        q_point= Mat.h;
        Mat = load(strcat('./Case1/db2_',num2str(i),'_point.mat'));
        db_point = Mat.h;
        db_point(isinf(db_point)|isnan(db_point)) = 0;
        q_point(isinf(q_point)|isnan(q_point)) = 0;
        [final_trans,aligned_q_mask] = Align(q_mask,db_mask); 
 
        aligned_point = imtranslate(q_point,final_trans,'FillValues',0,'OutputView','same');


        %Score Calculation
        
        h_score_HOG(i,j) = match_height_HOG(db_point,aligned_point,15); %Surface normal match
        
 end
%  break
    end
% break
end
name = strcat('./Case1/h_score_HOG',sess,'.mat');
save(name,'h_score_HOG');