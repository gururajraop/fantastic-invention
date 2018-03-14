function [output] = stitch(image1, image2)
    im1gray = rgb2gray(image1);
    im2gray = rgb2gray(image2);

    [matches, f1, f2, ~, ~] = keypoint_matching(im1gray, im2gray);
  

    [f1_new, t_new, transformation_1] = RANSAC(matches, f1, f2);
    plot_matching_points(image1, image2, t_new, f1, f1_new);
    interpolate(image1, transformation_1);
  

    output = zeros(50, 60);

end