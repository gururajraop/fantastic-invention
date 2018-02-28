function imOut = compute_LoG(image, LOG_type)

    switch LOG_type
        case 1
            imOut = imfilter(image, fspecial('gaussian', 5, 0.5));
            [Gx, Gy, ~, ~] = compute_gradient(imOut);
            [Gx2, ~, ~, ~] = compute_gradient(Gx);
            [~, Gy2, ~, ~] = compute_gradient(Gy);
            imOut = Gx2 + Gy2;
        case 2
            imOut = imfilter(image, fspecial('log', 5, 0.5));            
        case 3
            im1 = imfilter(image, fspecial('gaussian', 5, 200));
            im2 = imfilter(image, fspecial('gaussian', 5, 1));
            imOut = im1 - im2;           
    end
end

