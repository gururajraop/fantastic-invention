function [] = image_alignment()
    image1 = im2single(imread('./boat1.pgm'));
    image2 = im2single(imread('./boat2.pgm'));

    [matches, f1, f2, ~, ~] = keypoint_matching(image1, image2);
    size(matches)
    size(f1)
    size(f2)

    [f1_new, t_new, transformation_1] = RANSAC(matches, f1, f2);
    plot_matching_points(image1, image2, t_new, f1, f1_new);

%     m = [matches(2, :); matches(1, :)];
%     [f2_new, t_new, transformation_2] = RANSAC(m, f2, f1);
%     plot_matching_points(image2, image1, t_new, f2, f2_new);

end
