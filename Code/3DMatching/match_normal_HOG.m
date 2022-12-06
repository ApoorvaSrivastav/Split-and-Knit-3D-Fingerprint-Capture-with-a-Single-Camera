function score = match_normal_HOG(db,q,nbr)
     db_1 =db(:,:,1);
     q_1 = q(:,:,1);

     db_1(isinf(db_1)|isnan(db_1)) = 0;
     q_1(isinf(q_1)|isnan(q_1)) = 0;
     f_db1 = extractHOGFeatures(db_1,'CellSize',[nbr,nbr]);
     f_q1 = extractHOGFeatures(q_1,'CellSize',[nbr,nbr]);
     diff1 = sum(abs(f_db1 - f_q1));

     db_2 =db(:,:,2);
     q_2 = q(:,:,2);
     db_2(isinf(db_2)|isnan(db_2)) = 0;
     q_2(isinf(q_2)|isnan(q_2)) = 0;
     f_db2 = extractHOGFeatures(db_2,'CellSize',[nbr,nbr]);
     f_q2 = extractHOGFeatures(q_2,'CellSize',[nbr,nbr]);
     diff2 = sum(abs(f_db2 - f_q2));
     
     db_3 =db(:,:,3);
     q_3 = q(:,:,3);
     db_3(isinf(db_3)|isnan(db_3)) = 0;
     q_3(isinf(q_3)|isnan(q_3)) = 0;
     f_db3 = extractHOGFeatures(db_3,'CellSize',[nbr,nbr]);
     f_q3 = extractHOGFeatures(q_3,'CellSize',[nbr,nbr]);
     diff3 = sum(abs(f_db3 - f_q3));

     score = 1- (0.33*(diff1 + diff2 + diff3))/length(f_db1);
  
end