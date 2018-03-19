function [features] = get_features(image, type, color_space)
    if type == 'normal'
        switch color_space
            case 'gray'
                [~, features] = vl_sift(image);
        end
    end
end