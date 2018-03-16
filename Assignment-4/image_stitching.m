function [im_stichted] = image_stitching()

    image1 = im2single(imread('./left.jpg'));
    image2 = im2single(imread('./right.jpg'));

    im_stichted = stitch(image1, image2);
end