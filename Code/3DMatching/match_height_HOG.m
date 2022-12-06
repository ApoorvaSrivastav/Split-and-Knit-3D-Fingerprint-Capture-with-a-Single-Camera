function score = match_height_HOG(db,q,nbr)
 
     db(isinf(db)|isnan(db)) = 0;
     q(isinf(q)|isnan(q)) = 0;
     f_db1 = extractHOGFeatures(db,'CellSize',[nbr,nbr]);
     f_q1 = extractHOGFeatures(q,'CellSize',[nbr,nbr]);
     diff1 = sum(abs(f_db1 - f_q1));
     score = 1- (diff1)/length(f_db1);
  
end