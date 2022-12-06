function Data_points = Metrics(Score,n_fin,num_threshold)
GT =eye(n_fin);
threshold = linspace(0,1,num_threshold);
Data_points = zeros(size(Score,3),num_threshold,4);
color = ['r','g','b'];
%color = ['r','g'];
% EER = zeros(4,1);
% diff = zeros(4,num_threshold,1);
%FP =[];
for c=1:size(Score,3)
       for i =1:length(threshold)
        Count_TP =0;
        Count_FP =0;
        Count_FN =0;
        Count_TN =0;
        Prediction = imbinarize(Score(:,:,c),threshold(i));
        for j= 1:size(GT,1)
            for k= 1:size(GT,2)
                if GT(j,k)==0 && Prediction(j,k)==1
                    Count_FP = Count_FP +1;
                    %FP =[FP;c,i,j,k];
                elseif GT(j,k)==1 && Prediction(j,k)==1
                    Count_TP = Count_TP +1;
                elseif GT(j,k)==1 && Prediction(j,k)==0
                    Count_FN = Count_FN +1;
                elseif GT(j,k)==0 && Prediction(j,k)==0
                    Count_TN = Count_TN +1;
                end
            end
        end
        FAR = Count_FP/(Count_FP+Count_TN);%correct
        FRR = Count_FN/(Count_TP+Count_FN);%correct
        TRR = 1-FAR;%correct
        TAR = 1-FRR;%correct
        Data_points(c,i,:) = [FAR,TAR,FRR,TRR];

       end
    semilogx(Data_points(c,:,1),Data_points(c,:,2),'Color',color(c));
    hold all
    xlabel('False Acceptance Rate') 
    ylabel('True Acceptance Rate')
    title('ROC curve')
    legend({'Fingerprint Normal','Finger Shape Normal','Combined'},'Location','southeast')
  %  legend({'Fingerprint Normal','Finger Shape Normal'},'Location','southeast')
%     diff(c,:,1)= Data_points(c,:,1)- Data_points(c,:,3);
end
% figure,plot(threshold,Data_points(1,:,1),'Color','r');
% hold all
% plot(threshold,Data_points(1,:,3),'Color','b');
% title('FAR vs FRR ch1')
% xlabel('Threshold') 
% legend({'Red =FAR','Blue =FRR'},'Location','southwest')
% figure,plot(threshold,Data_points(2,:,1),'Color','r');
% hold all
% plot(threshold,Data_points(2,:,3),'Color','b');
% title('FAR vs FRR ch2')
% xlabel('Threshold') 
% legend({'Red =FAR','Blue =FRR'},'Location','southwest')
end
