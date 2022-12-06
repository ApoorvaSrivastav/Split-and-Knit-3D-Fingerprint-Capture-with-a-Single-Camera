import cv2
import numpy as np 
import matplotlib.pyplot as plt


path = './query/'+'/'

for i in range(41,42):
    I = cv2.imread(path+str(i)+'/Mean_White.jpg')
    I = cv2.cvtColor(I, cv2.COLOR_BGR2RGB)
#     I = cv2.medianBlur(I, 5)
#     I = cv2.GaussianBlur(I,(75,75),cv2.BORDER_DEFAULT)
    image_min = I.min(axis=2)
    min_avg = np.mean(image_min)
    minimum_rgb = cv2.merge((image_min,image_min,image_min)).astype(np.uint8)
    # Creating MSF 
    sub_im = cv2.subtract(I,minimum_rgb) 
    MSF = sub_im + min_avg
    MSF_sum = MSF[:,:,0] + MSF[:,:,1] + MSF[:,:,2]
    #Creating Chrom_image
    Chrom_im_r = np.divide(MSF[:,:,0],MSF_sum)
    Chrom_im_g = np.divide(MSF[:,:,1],MSF_sum)
    Chrom_im_b = np.divide(MSF[:,:,2],MSF_sum)
    Chrom_im = cv2.merge((Chrom_im_r,Chrom_im_g,Chrom_im_b))
    Chrom_im = cv2.GaussianBlur(Chrom_im,(101,101),cv2.BORDER_DEFAULT)
    #print(Chrom_im.dtype)
    plt.imshow((Chrom_im*255).astype(np.uint8))
    plt.show()
    #cv2.imwrite('chrom.jpg',(Chrom_im*255).astype(np.uint8))
    #k Means to further clean the mask
    image = (Chrom_im*255).astype(np.uint8)
    
    # Reshaping the image into a 2D array of pixels and 3 color values (RGB)
    pixel_vals = image.reshape((-1,3))

    # Convert to float type
    pixel_vals = np.float32(pixel_vals)
    #the below line of code defines the criteria for the algorithm to stop running,
    #which will happen is 100 iterations are run or the epsilon (which is the required accuracy)
    #becomes 99%
    criteria = (cv2.TERM_CRITERIA_EPS + cv2.TERM_CRITERIA_MAX_ITER, 500, 0.99)

    # then perform k-means clustering wit h number of clusters defined as 3
    #also random centres are initially choosed for k-means clustering
    k = 2
    retval, labels, centers = cv2.kmeans(pixel_vals, k, None, criteria, 10, cv2.KMEANS_RANDOM_CENTERS)

    # convert data into 8-bit values
    centers = np.uint8(centers)
    segmented_data = centers[labels.flatten()]

    # reshape data into the original image dimensions
    segmented_image = segmented_data.reshape((image.shape))

    #plt.imshow(segmented_image,cmap='gray')
    #cv2.imwrite('Silhouette.jpg',segmented_image)

    # generating masks
    Seg_gray = cv2.cvtColor(segmented_image,cv2.COLOR_BGR2GRAY)
    (thresh, Seg_gray) = cv2.threshold(Seg_gray, 55, 255, cv2.THRESH_BINARY | cv2.THRESH_OTSU)
    Seg_gray = 255 -Seg_gray
    #Seg_gray = cv2.GaussianBlur(Seg_gray,(75,75),cv2.BORDER_DEFAULT)
    plt.imshow(Seg_gray)
    plt.show()

    #cv2.imwrite(path+str(i)+'/White/mask1.jpg', Seg_gray)
    #cv2.imwrite(path+str(i)+'/IR/mask1.jpg', Seg_gray)

    
