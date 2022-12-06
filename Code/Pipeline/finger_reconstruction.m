function finger_reconstruction(id)
% type =0 for IR
% type =1 for White
global path 

for i =1:210
   %  i=81;
%       i= 7;
 if (i>70 &&i<=80)||(i>170 &&i<=180)||(i>90 &&i<=100)||(i>190 &&i<=200)
    continue
else
   
    try
        path = strcat('./',id,'/',num2str(i),'/');
        %%%reset(gpuDevice(1));
        Preprocess(path);
        [~,~,ext1]=PS(1,0,path,id,i);  %3 for 512 type =1 for White
        [~,~,ext2]=PS(0,2,path,id,i);  %2 for 912 type =0 for IR    0 for Chellappa
        Smoothing(path,1,ext1); 
        Smoothing(path,0,ext2);
        disp(strcat(id,'_',num2str(i),' is done'));
        close gcf
        close all
     catch        
        disp(strcat('Error in_',id,'_',num2str(i)));
     end
%         break
end
end
end