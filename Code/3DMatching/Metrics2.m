function Data_points = Metrics2(Score)% for 2000 sampled data 
num_threshold=1000;
GT =Score(:,7);
%GT =Score(:,6);
threshold = linspace(0,1,num_threshold);
Data_points = zeros(3,num_threshold,4);
color = ['r','g','b','k'];
%color = ['r','g'];
% EER = zeros(4,1);
% diff = zeros(4,num_threshold,1);
%FP =[];
for c=1:4

%for c=1:2
    for i =1:length(threshold)
        Count_TP =0;
        Count_FP =0;
        Count_FN =0;
        Count_TN =0;
        Prediction = imbinarize(Score(:,c),threshold(i));

        for j= 1:size(Score,1)
            if GT(j)==0 && Prediction(j)==1
                    Count_FP = Count_FP +1;
                   %disp('yo');
                    %FP =[FP;c,i,j,k];
                elseif GT(j)==1 && Prediction(j)==1
                    Count_TP = Count_TP +1;
                elseif GT(j)==1 && Prediction(j)==0
                    Count_FN = Count_FN +1;
                elseif GT(j)==0 && Prediction(j)==0
                    Count_TN = Count_TN +1;
            end
        end
   
        FAR = Count_FP/(Count_FP+Count_TN+eps);%correct
        FRR = Count_FN/(Count_TP+Count_FN+eps);%correct
        TRR = 1-FAR;%correct
        TAR = 1-FRR;%correct
        Data_points(c,i,:) = [FAR,TAR,FRR,TRR];

    end
   
semilogx(Data_points(c,:,1),Data_points(c,:,2),'Color',color(c),'LineWidth',6);
hold all
xlabel('False Acceptance Rate','fontweight','bold','fontsize',24) 
ylabel('True Acceptance Rate','fontweight','bold','fontsize',24)
%title('ROC curve for matching surface normals using LBP features for 170 unique fingers','fontsize',12)
%legend({'Combined','Fingerprint Normal','Finger Shape Normal'},'Location','southeast')
%legend({'Fingerprint Normal','Ridge-Valley Point Cloud','Finger Shape Normal'},'Location','southeast')
legend({'Fingerprint Normal','Finger Shape Normal','Ridge-Valley Point Cloud','Combined'},'Location','southeast','fontweight','bold','FontSize',18,'LineWidth',6) 
% diff(c,:,1)= Data_points(c,:,1)- Data_points(c,:,3);

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
