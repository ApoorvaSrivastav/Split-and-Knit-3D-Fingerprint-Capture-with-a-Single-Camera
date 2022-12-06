function Mean_white(id,min_no,max_no)
%names = ["indexL","indexR","middleL","middleR","ringL","ringR","pinkyL","pinkyR","thumbL","thumbR"];
I = imread(strcat('./',id,'/',num2str(min_no),'/White/0.jpg'));
[M,N,K]= size(I);
J = uint16(zeros(M,N,K));
for j=min_no:max_no
    for i =0:6
        J = J + uint16(imread(strcat('./',id,'/',num2str(j),'/White/',string(i),'.jpg')));
    end
    J = J/7;
    imwrite(uint8(J),strcat('./',id,'/',num2str(j),'/Mean_White.jpg'));
    %imshow(uint8(J));
end
end