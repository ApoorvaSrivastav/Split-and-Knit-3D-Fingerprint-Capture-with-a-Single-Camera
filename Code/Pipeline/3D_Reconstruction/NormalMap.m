function [surfNormals, albedo] = NormalMap( images, lightMatrix, maskImage, whichChannel)

    surfNormals = [];
    %Creating Matrices of required sizes depending on the image dimensions
    nrows     = size(images,1);                  
    ncols     = size(images,2); 
    numColors = size(images,3);
    numImages = size(images,4);
    %Initializing surface normals and albedo matrices
    for i = 1:nrows
    for j = 1:ncols
        surfNormals(i,j,1) = 0.0;
        surfNormals(i,j,2) = 0.0;
        surfNormals(i,j,3) = 1.0;
        albedo(i,j)        = 0.0;
    end
    end

    if( whichChannel == 0)        %if gray images is to be used for Normal Calculation
        for im = 1:numImages
	    grayimages(:,:,im) = rgb2gray(images(:,:,:,im));
        end
        
        for i = 1:nrows
        for j = 1:ncols
            if( maskImage(i,j) ) % calculating normal only for the pixels allowed by the mask
	        for im = 1:numImages
	            I(im) = double(grayimages(i,j,im));      % I contains allowed pixel value for each image for each location
            end
	        [NP,R,fail] = PixelNormal(I, lightMatrix);
	        surfNormals(i,j,1) =  NP(1);
	        surfNormals(i,j,2) =  NP(2);
	        surfNormals(i,j,3) =  NP(3);
	        albedo(i,j)        =  R;
            end
        end
        end
   end

   if( whichChannel > 0 ) 
       for i = 1:nrows
       for j = 1:ncols
           if( maskImage(i,j) ) 
	       for im = 1:numImages
	           I(im) = double(images(i,j, whichChannel, im));   % I contains all the images with allowed pixels after mask application
               end
	       [NP,R,fail] = PixelNormal(I, lightMatrix);
	       surfNormals(i,j,1) = NP(1);
	       surfNormals(i,j,2) = NP(2);
	       surfNormals(i,j,3) = NP(3);
	       albedo(i,j)        = R;
            end
        end
        end
    end

    maxval = max(max(albedo) );
    if( maxval > 0) 
        albedo = albedo/maxval;
    end

end

%*******************************************************************************

function [N,R, fail] = PixelNormal(I, L)              % Function to calculate the Surface Normals for allowed pixels

   fail = 0;                                          % I is of dimension (intensity of a pixel,numIm) L is of dimension (numIm,3)
                                                      % I=L.kN; let kN=G
                                                      % =>I=L.G =>L'I=L'LG
                                                      % G=kN/(||G||) gives N
                                                      % and k is albedo
                                                      
   I  = I';
   LT = L';
   A  = LT*L;
   b  = LT*I;
   g  = inv(A)*b;
   R  = norm(g);
   N  = g/R;

   if( norm(I) < 1.0E-06) 
       fprintf( ' Warning: Pixel intensity is zero \n' );
       N(1) = 0.0;
       N(2) = 0.0;
       N(3) = 0.0;
       R    = 0.0;
       fail = 1;
   end

end

%*******************************************************************************