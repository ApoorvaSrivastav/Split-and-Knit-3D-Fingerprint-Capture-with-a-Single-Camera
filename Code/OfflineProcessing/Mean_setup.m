I = imread('IR_light_0.jpg');
[M,N,K]= size(I);
J = uint16(zeros(M,N,K));
for i =1:7
    J = J + uint16(imread(strcat('IR_light_',string(i-1),'.jpg')));
end
J = J/7;
imwrite(uint8(J),'./Setup_mean.jpg');
imshow(uint8(J));