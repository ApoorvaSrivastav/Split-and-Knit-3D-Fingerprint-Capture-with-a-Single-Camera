function [Light_Mat,mu] = Light_Calibration(pix2cm,LED_height,LED_center,LED_radius,Nail_loc,tiplocation)
% pix2cm is pixel to cm ratio of camera at a particular position (integer)
% Basically pix2cm tells number of pixels for 1 cm
% LED_height is the height of the LED circle (float)in cm
% LED_center is the pixel location of the center of LED circle (xc,yc)pixel
% LED_radius is the radius of LED circle in cm (float)
% Nail_loc is the pixel location of nail (xn,yn)pixel
% tip_location is tip location of 7 images in terms of pixel. Its a 7x2
% array comprising of (xi,yi) for each image

% Reading the image

%im = imread('./Camera Setup/Images from Setup/11Oct/White/calib1_1.jpg');
%[M,N,C]=size(im);
M = 2000;% dfault size of Image
N = 3000;
%conversion to pixels
LED_height_pix = LED_height*pix2cm;
LED_radius_pix = LED_radius*pix2cm;

%conversion to camera coordinate system 
LED_center_cam = [LED_center(1)-M/2, LED_center(2)-N/2];
Nail_loc_cam = [Nail_loc(1)-M/2, Nail_loc(2)-N/2];
tip_location_cam(:,1)= tiplocation(:,1) - M/2;
tip_location_cam(:,2)= tiplocation(:,2) - N/2;

% Calculating LED position in Camera Coordinate System
A= Nail_loc_cam(1)- LED_center_cam(1);
C= Nail_loc_cam(2)- LED_center_cam(2);
position=zeros(7,2);
mu=zeros(7,2);
for i =1:7
    B= Nail_loc_cam(1)- tip_location_cam(i,1);
    D= Nail_loc_cam(2)- tip_location_cam(i,2);
%      B=  tip_location_cam(i,1)-Nail_loc_cam(1);
%      D=  tip_location_cam(i,2)-Nail_loc_cam(2);
    a= B*B + D*D;
    b= 2*(A*B + C*D);
    c= A*A + C*C - LED_radius_pix*LED_radius_pix;
    mu(i,:)=quad_equation(a,b,c);
    position(i,1)= Nail_loc_cam(1) + mu(i,1)*(Nail_loc_cam(1)- tip_location_cam(i,1));
    position(i,2)= Nail_loc_cam(2) + mu(i,1)*(Nail_loc_cam(2)- tip_location_cam(i,2));
    position(i,1) = LED_center(1)-position(i,1) - M/2;%converting back to pixel coordinate
    position(i,2) = LED_center(2)-position(i,2) - N/2;%converting back to pixel coordinate
end

Light_Mat = [position,LED_height_pix*ones(7,1)]; %(x,y,z) of LED
norm = vecnorm(Light_Mat,2,2); % calculating row wise norm
norm = [norm,norm,norm];
Light_Mat = Light_Mat./norm; %obtaining unit light vectors
end
  function x=quad_equation(a,b,c)
              x(1)=(-b+sqrt(b.^2-4.*a.*c))/(2.*a);
              x(2)=(-b-sqrt(b.^2-4.*a.*c))/(2.*a);
  end