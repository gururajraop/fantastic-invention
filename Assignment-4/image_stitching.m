function [] = image_stitching()

image1 = imread('./left.jpg');
image2 = imread('./right.jpg');

stitch(image1, image2);

end