im = im2double(imread('images/image2.jpg'));

figure
subplot(1, 3, 1)
imshow(compute_LoG(im, 1), [])
title('Gaussian + LoG')

subplot(1, 3, 2)
imshow(compute_LoG(im, 2), [])
title('Log')

subplot(1, 3, 3)
A = compute_LoG(im, 3);
imshow(A, [])
title('DoG')