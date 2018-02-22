function [] = recoloring()
    
    % Load the images into memory, convert to doubles
    shading = im2double(imread('ball_shading.png'));
    original = imread('ball.png');
    
    % preallocate memory for reconstruction of the images
    reconstructed_green = zeros(size(original));
    reconstructed_magenta = zeros(size(original));
    
    % instead of albedo use predefined colours
    green = [0, 1, 0];
    magenta = [1, 0, 1];
    
    % calculate pixel intensity foreach channel
    for c = 1:3
        reconstructed_green(:,:,c) = shading(:,:) .* green(c);
        reconstructed_magenta(:,:,c) = shading(:,:) .* magenta(c);        
    end
    
    % plot original and the two recolored images in one figure
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


