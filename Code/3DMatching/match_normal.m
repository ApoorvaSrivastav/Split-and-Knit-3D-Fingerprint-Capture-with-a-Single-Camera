function score = match_normal(db,q,nbr)
     db_1 =db(:,:,1);
     q_1 = q(:,:,1);

     db_1(isinf(db_1)|isnan(db_1)) = 0;
     q_1(isinf(q_1)|isnan(q_1)) = 0;
     f_db1 = extractLBPFeatures(db_1,'NumNeighbors',nbr,'Normalization','None','CellSize',[32,32]);
     f_q1 = extractLBPFeatures(q_1,'NumNeighbors',nbr,'Normalization','None','CellSize',[32,32]);
     diff1 = sum(abs(f_db1 - f_q1));

     db_2 =db(:,:,2);
     q_2 = q(:,:,2);
     db_2(isinf(db_2)|isnan(db_2)) = 0;
     q_2(isinf(q_2)|isnan(q_2)) = 0;
     f_db2 = extractLBPFeatures(db_2,'NumNeighbors',nbr,'Normalization','None','CellSize',[32,32]);
     f_q2 = extractLBPFeatures(q_2,'NumNeighbors',nbr,'Normalization','None','CellSize',[32,32]);
     diff2 = sum(abs(f_db2 - f_q2));
     
     db_3 =db(:,:,3);
     q_3 = q(:,:,3);
     db_3(isinf(db_3)|isnan(db_3)) = 0;
     q_3(isinf(q_3)|isnan(q_3)) = 0;
     f_db3 = extractLBPFeatures(db_3,'NumNeighbors',nbr,'Normalization','None','CellSize',[32,32]);
     f_q3 = extractLBPFeatures(q_3,'NumNeighbors',nbr,'Normalization','None','CellSize',[32,32]);
     diff3 = sum(abs(f_db3 - f_q3));

     score = 1- (0.33*(diff1 + diff2 + diff3))/length(f_db1);
  
end