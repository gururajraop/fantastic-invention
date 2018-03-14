function [] = image_stitching()

image1 = im2single(imread('./left.jpg'));
image2 = im2single(imread('./right.jpg'));
[h, w, c] = size(image1);
% image2 = imresize(image2, [h w]);


stichted_image = stitch(image1, image2);

% imshow(stichted_image);

end