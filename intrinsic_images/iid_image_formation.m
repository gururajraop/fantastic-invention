function [] = iid_image_formation()
    reflectance = im2double(imread('ball_reflectance.png'));
    shading = im2double(imread('ball_shading.png'));
    original = imread('ball.png');

    
    reconstructed = zeros(size(reflectance));
    
    
    for c = 1:3
        reconstructed(:,:,c) = shading(:,:) .* reflectance(:,:,c);
    end
    
    close all
    figure
    subplot(2, 2, 1);
    imshow(original);
    title('Original image');
    
    subplot(2, 2, 2);
    imshow(reconstructed);
    title('Reconstructed image');
    
    subplot(2, 2, 3);
    imshow(shading);
    title('Shading');
    
    subplot(2, 2, 4);
    imshow(reflectance);
    title('Reflectance');
    
end


