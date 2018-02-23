function [ PSNR ] = myPSNR( orig_image, approx_image )

    if ~isa(orig_image, 'double') | ~isa(approx_image, 'double')
        error('Both images should be converted to double to prevent overflow errors, use im2double')
    end
    [h, w] = size(orig_image);

    sse = sum(sum((orig_image - approx_image) .^ 2));
    mse = sse / (h * w);

    PSNR = 10 * log10(1^2/mse);

end

