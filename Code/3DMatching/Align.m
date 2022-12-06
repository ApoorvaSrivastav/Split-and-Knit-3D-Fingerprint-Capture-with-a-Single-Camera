function aligned_q = Align(q_mask,db_mask)    
%     q_mask=remove_noise(q_mask);
%     db_mask=remove_noise(db_mask);
%     imwrite(db_mask,'db.jpg');
%     imwrite(q_mask,'q.jpg');
%     q_mask =imread('q.jpg');
%     db_mask =imread('db.jpg');
    translate = [0,0];
    start_q = start_locate(q_mask);
    start_db = start_locate(db_mask);
    translate(1) =start_db(1)-start_q(1);
    translate(2) =start_db(2)-start_q(2);
    translated_q = imtranslate(q_mask,translate,'FillValues',0,'OutputView','same');
%     %start_translated = start_locate(translated_q);
%     figure, imshow(db_mask);
%     figure, imshow(translated_q);
    %db_mask = imbinarize(db_mask);
    %translated_q = imbinarize(translated_q);
    score = zeros(41,1);
    for i=-20:20
    shifted = circshift(translated_q,5*i,2);
%     disp(10*i);
%     disp(size(shifted));
%     disp(size(db_mask));
    score(i+21)= sum(sum(shifted & db_mask));
    end
    
    [~,index] = max(score,[],'linear');
%     disp(score);
%     disp(index);
    shift = (index-21)*5;
    aligned_q = imtranslate(translated_q,[shift,0],'FillValues',0,'OutputView','same');
%      figure, imshow(aligned_q);
    %final_trans = translate + [shift,0];
%     imwrite(aligned_q*255,'3.jpg');
end