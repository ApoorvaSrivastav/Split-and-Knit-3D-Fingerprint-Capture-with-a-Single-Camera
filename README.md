# Split-and-Knit-3D-Fingerprint-Capture-with-a-Single-Camera
Welcome to the project page of Split and Knit Algorithm!!!

3D fingerprint capture is less sensitive to skin moisture levels and avoids skin deformation, which is common in contact-based sensors, in addition to capturing depth information. Unfortunately, its adoption is limited due to high cost and system complexity. Photometric stereo provides an opportunity to build low-cost, simple sensors capable of high-quality $3D$ capture. However, it assumes that the surface being imaged is lambertian and does not work well with non-lambertian surfaces like our fingers.

We introduce the Split and Knit algorithm (SnK), a $3D$ reconstruction pipeline based on the photometric stereo for finger surfaces. It introduces an efficient way of estimating the direct illumination component, thus allowing us to do a higher-quality reconstruction of the entire finger surface. The algorithm also introduces a novel method to obtain the overall finger shape under NIR illumination, all using a single camera. Finally, we combine the overall finger shape and the ridge-valley point cloud to obtain a $3D$ finger phalange. The high-quality $3D$ reconstruction also results in better matching accuracy of the captured fingerprints.


![Teaser](https://user-images.githubusercontent.com/56497557/205968785-1b51a47a-b124-4a56-a2d4-68407eb8fd5b.png)

## Output Glimpse
https://user-images.githubusercontent.com/56497557/205968972-2e853257-c053-4847-a8ec-db09d957a428.mp4

## Reconstruction Steps
https://user-images.githubusercontent.com/56497557/205969342-2940af32-bbf3-4a43-96aa-a437b6e8435e.mp4

