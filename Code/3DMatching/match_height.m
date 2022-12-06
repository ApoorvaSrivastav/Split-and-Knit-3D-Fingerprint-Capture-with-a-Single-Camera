function score = match_height(db,q,nbr)
 
     db(isinf(db)|isnan(db)) = 0;
     q(isinf(q)|isnan(q)) = 0;
     f_db1 = extractLBPFeatures(db,'NumNeighbors',nbr,'Normalization','None','CellSize',[32,32]);
     f_q1 = extractLBPFeatures(q,'NumNeighbors',nbr,'Normalization','None','CellSize',[32,32]);
     diff1 = sum(abs(f_db1 - f_q1));
     score = 1- (diff1)/length(f_db1);
  
end