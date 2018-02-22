function [] = AWB()
    %%
    % load image into memory and preallocate space for corrected version
    original = im2double(imread('blue.jpg'));
    corrected = zeros(size(original));

    % calculate mean RGB color and illumination
    means = reshape(mean(mean(original, 2)), 3, []);
    new_means = [.5, .5, .5];
    
    % foreach color correct all pixels by multiplying by a factor
    % so that after correction the average R, G, and B value are equal to
    % the corresponding new_mean values which are in Grey-World
    % algorithm .5, .5, .5 which corresponds to the color grey
    for c = 1:size(means)
        corrected(:, :, c) = original(:, :, c) .* (new_means(c) / means(c));
    end
    
    %%
    % Plot the original and the corrected image in one figure
    close all;
    figure;
    
    subplot(1, 2, 1);
    imshow(original);
    title('Original');
    
    subplot(1, 2, 2);
    imshow(corrected);
    title('Corrected');     
    
end