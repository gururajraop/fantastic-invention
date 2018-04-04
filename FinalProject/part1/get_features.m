function [features] = get_features(image, sift_type, color_space)
    if strcmp(sift_type, 'normal')
        features = normal_sift(image, color_space);
    elseif strcmp(sift_type, 'dense')
        features = dense_sift(image, color_space);
    else
        error('Unexpected SIFT descriptor extraction type');
    end
    
    features = features';
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
%             Ideally we should extract feature for gray and then use the
%             same keypoints for the descriptor extraction
%             image_gray = image;
%             if size(image, 3) > 1
%                 image_gray = rgb2gray(image);
%             end
%             [F, ~] = vl_sift(image_gray);
%             D = get_desciptor(image, F);

        case 'nrgb'
            if size(image, 3) > 1
                image = im2single(rgb2normedrgb(image));
            end
            for c=1:size(image, 3)
                [~, Des] = vl_sift(image(:,:,c));
                D = [D, Des];
            end
        case 'opponent'
            if size(image, 3) > 1
                image = im2single(rgb2opponent(image));
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
            [~, D] = vl_dsift(image, 'step', 10);
        case 'RGB'
            for c=1:size(image, 3)                
                [~, Des] = vl_dsift(image(:,:,c), 'step', 10);
                D = [D, Des];
            end
        case 'nrgb'
            if size(image, 3) > 1
                image = im2single(rgb2normedrgb(image));
            end
            for c=1:size(image, 3)
                [~, Des] = vl_dsift(image(:,:,c), 'step', 10);
                D = [D, Des];
            end
        case 'opponent'
            if size(image, 3) > 1
                image = im2single(rgb2opponent(image));
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

function [D] = get_desciptor(image, F)
    D = zeros(3*size(F,2), 128);
    i = 1;
    for f=F
        for c=1:size(image, 3)
            f(3)
              I_ = vl_imsmooth(image(:,:,c), sqrt(f(3).^2 - 0.5^2));
              [Ix, Iy] = vl_grad(I_);
              mod = sqrt(Ix.^2 + Iy.^2);
              ang = atan2(Iy,Ix);
              grd = shiftdim(cat(3,mod,ang),2);
              grd = single(grd);
              d = vl_siftdescriptor(grd, f);
              D(i, :) = d';
              i = i + 1;
        end
    end
end



