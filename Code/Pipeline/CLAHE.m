function CLAHE(type,path)
if type ==1
    folder = 'White';
end
for i =0:6
I = imread(strcat(path,folder,'/F.',num2str(i),'.jpg'));
I = rgb2gray(I);
J = adapthisteq(I,'NumTiles',[64 64],'Range','full');
%J = histeq(I);
J = cat(3,J,J,J);
imwrite(J,strcat(path,folder,'/H.',num2str(i),'.jpg'));
end
%end









