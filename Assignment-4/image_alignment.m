function [] = image_alignment()
image1 = imread('./boat1.pgm');
image2 = imread('./boat2.pgm');

keypoint_matching(image1, image2);

RANSAC(image1, image2);
RANSAC(image2, image1);
end