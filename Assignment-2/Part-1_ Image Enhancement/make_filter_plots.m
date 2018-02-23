org = im2double(imread('images/image1.jpg'));
sp = im2double(imread('images/image1_saltpepper.jpg'));
gs = im2double(imread('images/image1_gaussian.jpg'));

myPSNR(org, sp)
myPSNR(org, gs)


figure
close all

%% PLOT SALTPEPPER BEST DENOISED
% subplot(1, 3, 1)
% denoised = denoise(sp, 'box', 3);
% imshow(denoised);
% title('Box 3');
% 
% subplot(1, 3, 2)
% denoised = denoise(sp, 'median', 3);
% imshow(denoised);
% title('Median 3')
% 
% subplot(1, 3, 3)
% denoised = denoise(sp, 'gaussian', 1, 3);
% imshow(denoised);
% title('Gaussian 3, sigma = 1')


%% PLOT GAUSSIAN BEST DENOISED
% subplot(1, 3, 1)
% denoised = denoise(gs, 'box', 3);
% imshow(denoised);
% title('Box 3');
% 
% subplot(1, 3, 2)
% denoised = denoise(gs, 'median', 3);
% imshow(denoised);
% title('Median 3')
% 
% subplot(1, 3, 3)
% denoised = denoise(gs, 'gaussian', 1, 3);
% imshow(denoised);
% title('Gaussian 3, sigma = 1')


%% PLOT SALTPPER DENOISED GAUSSIAN
% subplot(1, 3, 1)
% denoised = denoise(sp, 'gaussian', 0.5, 3);
% imshow(denoised);
% psnrr = myPSNR(org, denoised);
% title_str = sprintf('sigma = 0.5, psnr = %.2f', psnrr);
% title(title_str);
% 
% subplot(1, 3, 2)
% denoised = denoise(sp, 'gaussian', 1, 3);
% imshow(denoised);
% psnrr = myPSNR(org, denoised);
% title_str = sprintf('sigma = 1, psnr = %.2f', psnrr);
% title(title_str)
% 
% subplot(1, 3, 3)
% denoised = denoise(sp, 'gaussian', 2, 3);
% imshow(denoised);
% psnrr = myPSNR(org, denoised);
% title_str = sprintf('sigma = 2, psnr = %.2f', psnrr);
% title(title_str)

%% PLOT GAUSSIAN DENOISED GAUSSIAN
% subplot(1, 3, 1)
% denoised = denoise(gs, 'gaussian', 0.5, 3);
% imshow(denoised);
% psnrr = myPSNR(org, denoised);
% title_str = sprintf('sigma = 0.5, psnr = %.2f', psnrr);
% title(title_str);
% 
% subplot(1, 3, 2)
% denoised = denoise(gs, 'gaussian', 1, 3);
% imshow(denoised);
% psnrr = myPSNR(org, denoised);
% title_str = sprintf('sigma = 1, psnr = %.2f', psnrr);
% title(title_str)
% 
% subplot(1, 3, 3)
% denoised = denoise(gs, 'gaussian', 2, 3);
% imshow(denoised);
% psnrr = myPSNR(org, denoised);
% title_str = sprintf('sigma = 2, psnr = %.2f', psnrr);
% title(title_str)


%% PLOT ORIGINAL VS DIFF NOISE (1x3)
% subplot(1, 3, 1);
% imshow(org)
% title('Original')
% 
% subplot(1, 3, 2);
% imshow(sp)
% title('Salt&Pepper noise')
% 
% subplot(1, 3, 3);
% imshow(gs)
% title('Gaussian noise')

%% PLOT SALTPEPPER & GAUSSIAN DENOISED BOX/MED (4x3)
%% Image 1
% method = 'box';
% 
% param = 3;
% subplot(4, 3, 1)
% denoise_img = denoise(sp, method, param);
% psnr_f = myPSNR(org, denoise_img);
% imshow(denoise_img);
% title_str = sprintf('%s %d, psnr %.2f', method, param, psnr_f);
% title(title_str)
% 
% param = 5;
% subplot(4, 3, 2)
% denoise_img = denoise(sp, method, param);
% psnr_f = myPSNR(org, denoise_img);
% imshow(denoise_img);
% title_str = sprintf('%s %d, psnr %.2f', method, param, psnr_f);
% title(title_str)
% 
% param = 7;
% subplot(4, 3, 3)
% denoise_img = denoise(sp, method, param);
% psnr_f = myPSNR(org, denoise_img);
% imshow(denoise_img);
% title_str = sprintf('%s %d, psnr %.2f', method, param, psnr_f);
% title(title_str)
% 
% method = 'median';
% 
% param = 3;
% subplot(4, 3, 4)
% denoise_img = denoise(sp, method, param);
% psnr_f = myPSNR(org, denoise_img);
% imshow(denoise_img);
% title_str = sprintf('%s %d, psnr %.2f', method, param, psnr_f);
% title(title_str)
% 
% param = 5;
% subplot(4, 3, 5)
% denoise_img = denoise(sp, method, param);
% psnr_f = myPSNR(org, denoise_img);
% imshow(denoise_img);
% title_str = sprintf('%s %d, psnr %.2f', method, param, psnr_f);
% title(title_str)
% 
% param = 7;
% subplot(4, 3, 6)
% denoise_img = denoise(sp, method, param);
% psnr_f = myPSNR(org, denoise_img);
% imshow(denoise_img);
% title_str = sprintf('%s %d, psnr %.2f', method, param, psnr_f);
% title(title_str)
% 
% %% Second image
% 
% method = 'box';
% 
% param = 3;
% subplot(4, 3, 7)
% denoise_img = denoise(gs, method, param);
% psnr_f = myPSNR(org, denoise_img);
% imshow(denoise_img);
% title_str = sprintf('%s %d, psnr %.2f', method, param, psnr_f);
% title(title_str)
% 
% param = 5;
% subplot(4, 3, 8)
% denoise_img = denoise(gs, method, param);
% psnr_f = myPSNR(org, denoise_img);
% imshow(denoise_img);
% title_str = sprintf('%s %d, psnr %.2f', method, param, psnr_f);
% title(title_str)
% 
% param = 7;
% subplot(4, 3, 9)
% denoise_img = denoise(gs, method, param);
% psnr_f = myPSNR(org, denoise_img);
% imshow(denoise_img);
% title_str = sprintf('%s %d, psnr %.2f', method, param, psnr_f);
% title(title_str)
% 
% method = 'median';
% 
% param = 3;
% subplot(4, 3, 10)
% denoise_img = denoise(gs, method, param);
% psnr_f = myPSNR(org, denoise_img);
% imshow(denoise_img);
% title_str = sprintf('%s %d, psnr %.2f', method, param, psnr_f);
% title(title_str)
% 
% param = 5;
% subplot(4, 3, 11)
% denoise_img = denoise(gs, method, param);
% psnr_f = myPSNR(org, denoise_img);
% imshow(denoise_img);
% title_str = sprintf('%s %d, psnr %.2f', method, param, psnr_f);
% title(title_str)
% 
% param = 7;
% subplot(4, 3, 12)
% denoise_img = denoise(gs, method, param);
% psnr_f = myPSNR(org, denoise_img);
% imshow(denoise_img);
% title_str = sprintf('%s %d, psnr %.2f', method, param, psnr_f);
% title(title_str)