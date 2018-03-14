function [] = interpolate(image, transformation)
[h, w, c] = size(image);

m = reshape(transformation(1:4), 2, 2);
t = reshape(transformation(5:6), 2, 1);
corners = round([m * [1; 1] + t, m * [1; w] + t, m * [h; 1] + t, m * [h; w] + t]);
h_extra = -min(corners(1,:)) + 1;
w_extra = -min(corners(2,:)) + 1;
h_new = max(corners(1,:)) - min(corners(1,:)) + 1;
w_new = max(corners(2,:)) - min(corners(2,:)) + 1;

image_transformed = zeros(h_new, w_new, c);

for x = 1:h
    for y = 1:w
        coor = round(m * [x;y] + t) + [h_extra; w_extra];
        image_transformed(coor(1), coor(2), :) = image(x, y, :);
    end
end

T_m = [m' t; 0 0 1]';
T = maketform('affine', T_m);
img_matlab = imtransform(image, T);

figure()
subplot(1,3,1), imshow(image); title('Original Image');
subplot(1,3,2), imshow(image_transformed); title('Transformed Image');
subplot(1,3,3), imshow(img_matlab); title('Matlab tranformation');

end