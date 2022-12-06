function cost = match_mask_shapecontext(mask_db,mask_q,gap)
db = bwboundaries(mask_db); 
[~,n] = max(cellfun(@numel,db));
db = db{n};
db = db(1:gap:end,:); 
%disp(size(db));
q = bwboundaries(mask_q); 
[~,n] = max(cellfun(@numel,q));
q = q{n};
q = q(1:gap:end,:); 
[~,cost] = shapeContext(db, q, 5, 6);
end