function visualize(input_image, color_space)
% Plot the results of converted color space
figure

% The output image
subplot(2,2,1);
if strcmp(color_space(1, 1), 'MatLab-Builtin')
    imshow(input_image(:, :, 4));
else
    imshow(input_image);
end
title(color_space(1, 1));

subplot(2,2,2);
imshow(input_image(:, :, 1))
title(color_space(1, 2))

subplot(2,2,3);
imshow(input_image(:, :, 2))
title(color_space(1, 3))

subplot(2,2,4);
imshow(input_image(:, :, 3))
title(color_space(1, 4))

end

