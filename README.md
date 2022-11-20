# Split-and-Knit-3D-Fingerprint-Capture-with-a-Single-Camera
Welcome to the project page of Split and Knit Algorithm!!!

$3D$ fingerprint capture is less sensitive to skin moisture levels and avoids skin deformation, which is common in contact-based sensors, in addition to capturing depth information. Unfortunately, its adoption is limited due to high cost and system complexity. Photometric stereo provides an opportunity to build low-cost, simple sensors capable of high-quality $3D$ capture. However, it assumes that the surface being imaged is lambertian and does not work well with non-lambertian surfaces like our fingers.

We introduce the Split and Knit algorithm (SnK), a $3D$ reconstruction pipeline based on the photometric stereo for finger surfaces. It introduces an efficient way of estimating the direct illumination component, thus allowing us to do a higher-quality reconstruction of the entire finger surface. The algorithm also introduces a novel method to obtain the overall finger shape under NIR illumination, all using a single camera. Finally, we combine the overall finger shape and the ridge-valley point cloud to obtain a $3D$ finger phalange. The high-quality $3D$ reconstruction also results in better matching accuracy of the captured fingerprints.

https://user-images.githubusercontent.com/56497557/202926783-f2195408-d265-4d05-9953-7aec18822b2b.mp4

