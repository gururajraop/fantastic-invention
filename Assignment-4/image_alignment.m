function [] = image_alignment()
image1 = im2single(imread('./boat1.pgm'));
image2 = im2single(imread('./boat2.pgm'));

keypoints = keypoint_matching(image1, image2);

RANSAC(image1, image2);
RANSAC(image2, image1);
end