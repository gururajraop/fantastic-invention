function [output] = stitch(image1, image2)
    im1gray = rgb2gray(image1);
    im2gray = rgb2gray(image2);

    [matches, f1, f2, ~, ~] = keypoint_matching(im1gray, im2gray);
  

    [f1_new, t_new, transformation_1] = RANSAC(matches, f1, f2);
%     plot_matching_points(image1, image2, t_new, f1, f1_new);
    image1_new = interpolate(image1, transformation_1);   
    t = round(reshape(transformation_1(5:6), 2, 1))


    [h2, w2, c] = size(image2);
    [h1, w1, ~] = size(image1_new);
    [h1org, w1org, ~] = size(image1);
    
    t = -t;
    t_extra = [h1 - h1org, w1 - w1org]
    
    new_h = max(h1, h2);
    output = zeros(new_h, w2 + t(1) + t_extra(2), c);
    
    output(:, 1:w1, :) = image1_new;

    for x = 1:h2
        for y = 1:w2
            x_coord = x + t(2) + 0;
            y_coord = y + t(1) + t_extra(2);

            if x_coord > 0 && y_coord > 0
%                 if mean(output(x_coord, y_coord), 3) > 0
%                     output(x_coord, y_coord, :) = 2* (.5 * image2(x, y, :) + .5 * output(x_coord, y_coord, :));
%                 else
                    output(x_coord, y_coord, :) = image2(x, y, :);
%                 end                
            end
        end
    end
    

    figure    
    imshow(output);

end