function [features] = get_features(image, sift_type, color_space)
    if strcmp(sift_type, 'normal')
        features = normal_sift(image, color_space);
    elseif strcmp(sift_type, 'dense')
        features = dense_sift(image, color_space);
    else
        error('Unexpected SIFT descriptor extraction type');
    end
end

function [D] = normal_sift(image, color_space)
    D = [];
    switch color_space
        case 'gray'
            if size(image, 3) > 1
                image = rgb2gray(image);
            end
            [~, D] = vl_sift(image);
        case 'RGB'
            for c=1:size(image, 3)
                [~, Des] = vl_sift(image(:,:,c));
                D = [D, Des];
            end
        case 'nrgb'
            if size(image, 3) > 1
                image = single(rgb2normedrgb(image));
            end
            for c=1:size(image, 3)
                [~, Des] = vl_sift(image(:,:,c));
                D = [D, Des];
            end
        case 'opponent'
            if size(image, 3) > 1
                image = single(rgb2opponent(image));
            end
            for c=1:size(image, 3)
                [~, Des] = vl_sift(image(:,:,c));
                D = [D, Des];
            end
        otherwise
            warning('Unexpected color space type');
    end
end

function [D] = dense_sift(image, color_space)
    D = [];
    switch color_space
        case 'gray'
            if size(image, 3) > 1
                image = rgb2gray(image);
            end
            [~, D] = vl_dsift(image);
        case 'RGB'
            for c=1:size(image, 3)
                [~, Des] = vl_dsift(image(:,:,c), 'step', 10);
                D = [D, Des];
            end
        case 'nrgb'
            if size(image, 3) > 1
                image = single(rgb2normedrgb(image));
            end
            for c=1:size(image, 3)
                [~, Des] = vl_dsift(image(:,:,c), 'step', 10);
                D = [D, Des];
            end
        case 'opponent'
            if size(image, 3) > 1
                image = single(rgb2opponent(image));
            end
            for c=1:size(image, 3)
                [~, Des] = vl_dsift(image(:,:,c), 'step', 10);
                D = [D, Des];
            end
        otherwise
            warning('Unexpected color space type');
    end
end

function [output_image] = rgb2normedrgb(input_image)
output_image = zeros(size(input_image));

R = input_image(:,:,1);
G = input_image(:,:,2);
B = input_image(:,:,3);
norm = R + G + B;

output_image(:, :, 1) = R ./ (norm);
output_image(:, :, 2) = G ./ (norm);
output_image(:, :, 3) = B ./ (norm);
end

function [output_image] = rgb2opponent(input_image)
output_image = zeros(size(input_image));

R = input_image(:,:,1);
G = input_image(:,:,2);
B = input_image(:,:,3);

output_image(:, :, 1) = (R - G) / sqrt(2);
output_image(:, :, 2) = (R + G - (2 * B)) / sqrt(6);
output_image(:, :, 3) = (R + G + B) / sqrt(3);

end



