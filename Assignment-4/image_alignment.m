function [] = image_alignment()
    image1 = im2single(imread('./boat1.pgm'));
    image2 = im2single(imread('./boat2.pgm'));

    [matches, f1, f2, ~, ~] = keypoint_matching(image1, image2);
    size(matches)
    size(f1)
    size(f2)

    RANSAC(matches, f1, f2);
    RANSAC(matches, f2, f1);
end