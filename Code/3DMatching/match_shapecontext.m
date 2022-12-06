function [cost_top,cost_side] = match_shapecontext(path_db,path_q)
Mat = load(strcat(path_db,'/IR/Results/side.mat'),'C');
db_side =Mat.C;
Mat = load(strcat(path_q,'/IR/Results/side.mat'),'C');
q_side =Mat.C;
%disp(size(q_side));
q_side =q_side(1:10:end,:);
db_side =db_side(1:10:end,:);
%disp(size(q_side));
%Compute
[~,cost_side] = shapeContext(db_side, q_side, 2, 3);

Mat = load(strcat(path_db,'/IR/Results/top.mat'),'C1');
db_top =Mat.C1;
Mat = load(strcat(path_q,'/IR/Results/top.mat'),'C1');
q_top =Mat.C1;
%disp(size(q_top));
q_top =q_top(1:10:end,:);
db_top =db_top(1:10:end,:);
%disp(size(q_top));
%Compute
[~,cost_top] = shapeContext(db_top, q_top, 2, 3);
end