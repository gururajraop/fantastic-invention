close all

im = im2double(imread('images/image2.jpg'));
I = im;

%% Matlab implementation to compare to, not used in report
[Gx, Gy] = imgradientxy(I);
[Gmag, Gdir] = imgradient(Gx, Gy);

figure
subplot(2, 2, 1);
imshow(Gx)
title('Directional gradient: X axis')

subplot(2, 2, 2);
imshow(Gy)
title('Directional gradient: Y axis')

subplot(2, 2, 3);
imshow(Gmag)
title('Gradient magnitude')

subplot(2, 2, 4);
imshow(Gdir)
title('Gradient direction')

%% Our implementation
[Gx, Gy, im_magnitude, im_direction] = compute_gradient(im);
figure

subplot(2, 2, 1);
imshow(Gx)
title('Directional gradient: X axis')

subplot(2, 2, 2)
imshow(Gy)
title('Directional gradient: Y axis')

subplot(2, 2, 3)
imshow(im_magnitude)
title('Gradient magnitude')

subplot(2, 2, 4)
imshow(im_direction)
title('Gradient direction')