# FaceRecognition
This is an algorithm for face detection and face recognition in still images using PCA and eigenfaces. The algorithm was implemented as part of the course 'Advanced Image Processing and Analysis' (TNM034) during 4 weeks in the fall of 2019 by Martin Hag and Josefine Klintberg. 

The algorithm recieved a recognition rate of 88% for a limited database of 16 faces (from the Caltech face database) with additional transformations such as scaling, translation, in-plane rotation and changes in tone values.  

<h1>Algorithm Walkthrough</h1>

<h2>Face mask</h2>
The usage of a face mask is to only keep relevant areas usable for the face detection algorithm by masking out the face. The face mask is created by finding the skin tone for humans in the image. Since the skin tones in the face is better described in YCbCr, than RGB values, the image is converted into the YCbCr color space. This color space is described by a luma component, Y, and the blue-difference component, Cb, and the red-difference component, Cr. Thresholds are used to limit all channels individually so only the skin color area are kept in the image, we found that the limits below represented the skin tones in our databases in a good way for implementation of the face mask. 

<img src="./img/facemaskes.jpg"/>

The area for the skin color is made into a binary image which is the foundation for the mask. Morphological operations are then applied to the image to clean it from small irregularities. The operations used are in following order opening, closing, dilation. A flood fill algorithm is then used followed by erosion which becomes the final mask.

<h2>Eye maps</h2>
A good way to identify a face is to find the eyes. An eye map can be produced using the fact that the eyes has tones which are distinct from the rest of the face. The approach used is to combine two separate methods of making a eye map because with the use of two methods, the chances of finding the eyes will increase. The two maps are using information inside the chrominance component and the luminance component of the image and then combined into one image and turned into a binary mask. Additional morphological operations are then performed to clean up the binary image. 

<img src="./img/eyemaps.jpg"/>
<img src="./img/eyemapsMorph.jpg"/>

<h2>Eye detection</h2>
The actual detection of eyes and deciding their coordinates in the image can be done in a multiple of ways. In this algorithm, the eyes are represented as two points inside the image, one for the left and one for the right. The best possible representation of the eyes are found when the point is in the center of the pupils for both eyes. 

The first thing is to create an association between all pixels and its corresponding area in the mask. Then all pixels for each area inside the mask is counted and the areas are sorted depending on how many pixels it has. The two areas that contains the largest amounts of pixels are chosen as the eye candidates and the other ones are ignored. The mean value for all pixels in those two areas are calculated, which then are used as points to represent the eyes positions.

In the best case, there are only two separated areas inside the image, where the eyes easily can be determined to be inside each one of those areas. In the cases where there are more than two eye candidates, a selection has to be made for which to pick. 

Since the eyes are found by using mean of the pixels in an area surrounding the eyes, the position is not exactly at the middle of the pupil. To get the exact position, circles are searched for in the face by using a circular Hough transform on the gray scale image.
If a circle is found and it is close to the point that was received using the mean method, the position is moved to the center of that circle.

This approach does not take in consideration if the eyes are humanly possible to be located in such a way. The found eye position can be above each other, which is known to be wrong with images containing a small amount of rotation of the head. 

<h2>Image transformations </h2>
When the eye candidates have been found, it is time to prepare the images for the face recognition part. For the eigenfaces to work well, the image has to fulfill some criteria before using them. All images has to be the same size. The faces in the images has to be aligned and only the face should be inside the image and no disturbing background should exist. In this algorithm, the position of the eyes are used for first a rotation to a horizontal line, then scaling according to a set number of pixels between the eyes and lastly cropped into a set image size. 

Additionally, a test to check light interference are used and if the light is not sufficient enough, gray world compensation is performed. 

<h2>PCA and Eigenfaces</h2>
The method of principal component analysis is used for reducing the resolution of the images and the images are now represented as a vector. From each vector, the mean-face is subtracted, then the covariance matrix are found and the eigenvectors calculated. Each eigenvector can be expressed as a linear combination of weights and all weights for the database are stored as a matrix before the running of the program to reduce calculation time.

Face comparison between an input image and the images in the database can then be done by calculating the euclidian distance between them, by using the weights. 

<img src="./img/mreig.jpg"/>
<img src="./img/mrseig.jpg"/>
<i>Visualization of eigenfaces</i>
