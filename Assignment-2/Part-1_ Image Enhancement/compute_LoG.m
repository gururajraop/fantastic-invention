function imOut = compute_LoG(image, LOG_type)

    switch LOG_type
        case 1
            imOut = imfilter(image, fspecial('gaussian', 5, 0.5));
            imOut = imfilter(imOut, fspecial('log', 5, 0.5));
        case 2
            imOut = imfilter(image, fspecial('log', 5, 0.5));            
        case 3
            im1 = imfilter(image, fspecial('gaussian', 3, 1.6));
            im2 = imfilter(image, fspecial('gaussian', 3, 1));
            imOut = im1 - im2;           
    end
    imOut = imOut ./ max(max(imOut));
end

