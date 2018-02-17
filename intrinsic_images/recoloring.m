function [] = recoloring()
    reflectance = im2double(imread('ball_reflectance.png'));
    shading = im2double(imread('ball_shading.png'));
    original = imread('ball.png');
    
    reconstructed_green = zeros(size(reflectance));
    reconstructed_magenta = zeros(size(reflectance));
    
    reconstructed_green(:,:,2) = shading(:,:) .* 1;
    
    reconstructed_magenta(:,:,1) = shading(:,:) .* 1;
    reconstructed_magenta(:,:,3) = shading(:,:) .* 1;
    
    
    close all
    figure
    subplot(1, 3, 1);
    imshow(original);
    title('Original');
    
    subplot(1, 3, 2);
    imshow(reconstructed_green);
    title('Green');
    
    subplot(1, 3, 3);
    imshow(reconstructed_magenta);
    title('Magenta');    
end


