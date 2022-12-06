function [surfNormals,z,ext] =  PS(type,method,path,category,number)
if type ==1
    folder = 'White';
    lightMatrix = load('./Calibration/Light_White.mat');
else
    folder = 'IR';
    lightMatrix = load('./Calibration/Light_IR.mat');
end
    directory = strcat(path,folder,'/');
    imagename = 'F';
    
    numImages = 7;
    %numImages = 12;
  %Read the lights and directions:
%   ***********************************************************************
   % numLights = 7;
    %numLights = 12;
    %lightMatrix = load('C:\Users\Asus\Documents\Research\3DFingerprint\After8May\PhotometricStereo\New_Code\Images\11Oct\Light.mat');
    
    
    lightMatrix = cell2mat(struct2cell( lightMatrix) );
 
    maskfile  = strcat( directory, imagename, '.mask.jpg'); %thresholding the mask for a given image
    maskImage = imread( maskfile );

    nrows  = size(maskImage,1);
    ncols  = size(maskImage,2);

    maxval = max(max(maskImage) );

    for i = 1:nrows
    for j = 1:ncols
       if( maskImage(i,j) == maxval)
           maskImage(i,j) = 1;
       else
           maskImage(i,j) = 0;
       end
    end
    end

%   *****************************************************************************
%   Read all the images .,, ( In RGB Format...
%   *****************************************************************************
    accumImage = zeros(nrows, ncols, 3);           % Summing the pixel-wise values of all images of same object 
%   Read all the images..                          % in different lights in a single matrix 
    for im = 1:numImages                           % numImages provided as input to the functionn at the very beginning
        id = num2str(im-1);
        filename = strcat( directory, imagename, '.', id, '.jpg');
        newImage = imread(filename);                   % each image is read in the variable newImage one-by-one
	if( size(newImage,1) ~= nrows) 
	    fprintf( ' mask image and source image size do not match ');
	    return;
    end
	if( size(newImage,2) ~= ncols) 
	    fprintf( ' mask image and source image size do not match ');
	    return;
    end

        for i = 1:nrows
        for j = 1:ncols
            accumImage(i,j,1) = accumImage(i,j,1) + double(newImage(i,j,1));
            accumImage(i,j,2) = accumImage(i,j,2) + double(newImage(i,j,2));
            accumImage(i,j,3) = accumImage(i,j,3) + double(newImage(i,j,3));
        end
        end

	images(:,:,:,im) = newImage;                          % Matrix containing all rgb images of one object 
	grayImageSet(:,:,im) = rgb2gray(newImage);            % Matrix containing all gray images of one object 
    end

    for i = 1:nrows
    for j = 1:ncols
        r = accumImage(i,j,1);
        g = accumImage(i,j,2);
        b = accumImage(i,j,3);                               % Masking out those image pixel regions 
       if( r  < 1.0 || g < 1.0 || b < 1.0 )              % where lighting couldn't reach in any lighting condition 
           maskImage(i,j) = 0;                           % and hence can't be used for photomeetric stereo calculation
       end
    end
    end
z = zeros(nrows, ncols);                           % Matrix of zeros equal to size of one image channel


%Normal Calculations
[surfNormals, albedo] = NormalMap(images, lightMatrix, maskImage, 0);
% save(strcat(directory,'Results/normal.mat'),'surfNormals');
% save(strcat(directory,'Results/albedo.mat'),'albedo');
% if type==0
%     save(strcat('./Results/',category,'_',num2str(number),'_IR.mat'),'surfNormals');
% else
%     save(strcat('./Results/',category,'_',num2str(number),'_White.mat'),'surfNormals');
%     White_mask = imread(strcat(directory,'F.mask1.jpg'));
%     imwrite(White_mask,strcat('./Results/',category,'_',num2str(number),'_mask.jpg'));
% end
disp('Depth Calculations begin');
  
% Chellappa
if method == 0
    ext = 'Chellappa';
    recsurf = GradientofNormal_v2(surfNormals,maskImage);
     figure,
    fig = surfl(recsurf);   %function to create 3D depthmap
     shading interp;colormap gray;title("Chellappa")
    saveas(fig,strcat(directory,'Results/',imagename,ext,'.fig'));
    point_cloud_generator(recsurf,directory,'Results',ext); 
    save(strcat(directory,'Results/finger_raw',ext,'.mat'),'recsurf');
end


%Shapelet
if method == 1
    ext = '712';
    [Gradx,Grady] = normal2gradient(surfNormals,maskImage);
    [slant, tilt] = grad2slanttilt(Gradx, Grady);
    recsurf = shapeletsurf(slant, tilt, 7, 1, 2, 'slanttilt');
    recsurf = recsurf.*double(maskImage);
     figure,
    fig=surfl(recsurf);   %function to create 3D depthmap
     shading interp;colormap gray;title("712slanttilt")
    saveas(fig,strcat(directory,'Results/',imagename,ext,'.fig'));
    point_cloud_generator(recsurf,directory,'Results',ext); 
    save(strcat(directory,'Results/finger_raw',ext,'.mat'),'recsurf');
end

if method == 2
    ext ='912';
    [Gradx,Grady] = normal2gradient(surfNormals,maskImage);
    [slant, tilt] = grad2slanttilt(Gradx, Grady);
    recsurf = shapeletsurf(slant, tilt, 9, 1, 2, 'slanttilt');
    recsurf = recsurf.*double(maskImage);
    figure,
    fig=surfl(recsurf);   %function to create 3D depthmap
     shading interp;colormap gray;title("912slanttilt")
    saveas(fig,strcat('./',directory,'/Results/',imagename,ext,'.fig'));
    point_cloud_generator(recsurf,directory,'Results',ext); 
    save(strcat(directory,'Results/finger_raw',ext,'.mat'),'recsurf');
end
if method == 3
    ext ='512';
    [Gradx,Grady] = normal2gradient(surfNormals,maskImage);
    [slant, tilt] = grad2slanttilt(Gradx, Grady);
    recsurf = shapeletsurf(slant, tilt, 5, 1, 2, 'slanttilt');
    recsurf = recsurf.*double(maskImage);
     figure,
    fig = surfl(recsurf);   %function to create 3D depthmap
     shading interp;colormap gray;title("512slanttilt")
    saveas(fig,strcat(directory,'Results/',imagename,ext,'.fig'));
    point_cloud_generator(recsurf,directory,'Results',ext); 
    save(strcat(directory,'Results/finger_raw',ext,'.mat'),'recsurf');
end

if method == 4
    ext = '511.5';
    [Gradx,Grady] = normal2gradient(surfNormals,maskImage);
    [slant, tilt] = grad2slanttilt(Gradx, Grady);
    recsurf = shapeletsurf(slant, tilt, 5, 1, 1.5, 'slanttilt');
    recsurf = recsurf.*double(maskImage);
    figure,
    fig = surfl(recsurf);   %function to create 3D depthmap
    shading interp;colormap gray;title("511.5slanttilt")
    saveas(fig,strcat(directory,'Results/',imagename,ext,'.fig'));
    point_cloud_generator(recsurf,directory,'Results',ext); 
    save(strcat(directory,'Results/finger_raw',ext,'.mat'),'recsurf');
end 
if method == 5
    ext = '412';
    [Gradx,Grady] = normal2gradient(surfNormals,maskImage);
    [slant, tilt] = grad2slanttilt(Gradx, Grady);
    recsurf = shapeletsurf(slant, tilt, 4, 1, 2, 'slanttilt');
    recsurf = recsurf.*double(maskImage);
    figure,
    fig = surfl(recsurf);   %function to create 3D depthmap
    shading interp;colormap gray;title("412slanttilt")
    saveas(fig,strcat(directory,'Results/',imagename,ext,'.fig'));
    point_cloud_generator(recsurf,directory,'Results',ext); 
    save(strcat(directory,'Results/finger_raw',ext,'.mat'),'recsurf');
end
if method == 6
    ext = '612';
    [Gradx,Grady] = normal2gradient(surfNormals,maskImage);
    [slant, tilt] = grad2slanttilt(Gradx, Grady);
    recsurf = shapeletsurf(slant, tilt,6, 1, 2, 'slanttilt');
    recsurf = recsurf.*double(maskImage);
    figure,
    fig = surfl(recsurf);   %function to create 3D depthmap
    shading interp;colormap gray;title("612slanttilt")
    saveas(fig,strcat(directory,'Results/',imagename,ext,'.fig'));
    point_cloud_generator(recsurf,directory,'Results',ext); 
    save(strcat(directory,'Results/finger_raw',ext,'.mat'),'recsurf');
end

end
