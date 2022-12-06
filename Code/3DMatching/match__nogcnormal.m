sess ='3to4';
% first = 'db2_nogc';
% second = 'query2_nogc';
% sess ='1to4';
% first = 'db';
% second = 'query2_';
% sess ='2to3';
% first = 'query';
% second = 'db2_';
% sess ='2to4';
% first = 'query';
% second = 'query2_';
% sess ='3to4';
% first = 'db2_';
% second = 'query2_';
score = double(zeros(210,210));

for i=1:210
for j=1:210
    try
        if (i>70 &&i<=80)||(i>170 &&i<=180)||(i>90 &&i<=100)||(i>190 &&i<=200)||(j>70 &&j<=80)||(j>170 &&j<=180)||(j>90 &&j<=100)||(j>190 &&j<=200)
            continue
        else
                % Reading the data for matching 
                q_mask = imread(strcat('./q2_nogc/',num2str(j),'/White/F.mask1.jpg'));
                db_mask = imread(strcat('./db2_nogc/',num2str(i),'/White/F.mask1.jpg'));

                q_mask = imbinarize(q_mask);
                db_mask = imbinarize(db_mask);

                Mat = load(strcat('./q2_nogc/',num2str(j),'/White/Results/normal.mat'));
                q_normal =Mat.surfNormals;
                Mat = load(strcat('./db2_nogc/',num2str(i),'/White/Results/normal.mat'));
                db_normal= Mat.surfNormals;

                [final_trans,aligned_q_mask] = Align(q_mask,db_mask); 

                aligned_normal_q = imtranslate(q_normal,final_trans,'FillValues',0,'OutputView','same');

                %Score Calculation

                score(i,j) = match_normal_HOG(db_normal,aligned_normal_q,15); %Fingerprint normal match

        end
    catch
        disp(strcat('Error in matching',num2str(i),'_',num2str(j)));
    end
% break
end
% break
end
name = strcat('./Case3/score_normal_3to4_nogc_HOG.mat');
save(name,'score');