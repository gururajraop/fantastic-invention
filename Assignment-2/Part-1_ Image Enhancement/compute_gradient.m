function [Gx, Gy, im_magnitude, im_direction] = compute_gradient(image)
    sobel_x = [1, 0, -1; 2, 0, -2; 1, 0, -1];
    sobel_y = -1 .* rot90(sobel_x); 
    
    Gx = imfilter(image, sobel_x, 'conv');
    Gy = imfilter(image, sobel_y, 'conv');
    
    im_magnitude = (Gx.^2 + Gy.^2).^(1/2);    
    im_direction = atand(Gy./Gx);
end

