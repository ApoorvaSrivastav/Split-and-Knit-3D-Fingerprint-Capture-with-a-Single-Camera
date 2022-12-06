function Smoothing(path,type,ext)
if type==1
    folder = 'White';

z = load(strcat(path,folder,'/Results/finger_raw',ext,'.mat'),'recsurf');
Z = z.recsurf;
m = imbinarize(imread(strcat(path,folder,'/F.mask.jpg')));
Z = Z.*double(m);
% figure,surfl(Z);   
% shading interp;colormap gray;title("masked")
[M,N] = size(Z);
eps = 0.5;
k=0;
while(k<1)
Z_new = zeros(size(Z));
for i = 3:M-2
    for j=3:N-2
        A = Z(i-2:i+2,j-2:j+2);
        sum_=sum(A,'all');
        Z_new(i,j) = (1-eps)*Z(i,j) + (eps/sum_)*summation(i,j,A);
    end
end
Z = Z_new;
k = k+1;
end
% figure,surfl(Z_new);
% shading interp;colormap gray;title("Z_new")
point_cloud_generator(Z_new,strcat(path,folder,'/'),'Results',strcat('smooth_',ext));
save(strcat(path,folder,'/Results/fingerprint',ext,'_smooth.mat'),'Z_new');

elseif type == 0
folder = 'IR';
z = load(strcat(path,folder,'/Results/finger_raw',ext,'.mat'),'recsurf');
Z = z.recsurf;
m = imbinarize(imread(strcat(path,folder,'/F.mask.jpg')));
Z = Z.*double(m);
% figure,surfl(Z);   
% shading interp;colormap gray;title("masked")
[M,N] = size(Z);
eps = 0.5;
k=0;
while(k<1)
Z_new = zeros(size(Z));
for i = 3:M-2
    for j=3:N-2
        A = Z(i-2:i+2,j-2:j+2);
        sum_=sum(A,'all');
        Z_new(i,j) = (1-eps)*Z(i,j) + (eps/sum_)*summation(i,j,A);
    end
end
Z = Z_new;
k = k+1;
end
% figure,surfl(Z_new);
% shading interp;colormap gray;title("Z_new")
point_cloud_generator(Z_new,strcat(path,folder,'/'),'Results',strcat('smooth_',ext));
save(strcat(path,folder,'/Results/finger',ext,'_smooth.mat'),'Z_new');
end
end
function S = summation(i,j,A)
        S=0;
        for k=1:size(A,1)
            for l=1:size(A,2)
                S = S + (1/norm([k,l]-[i,j]))*A(k,l);
            end
        end
end