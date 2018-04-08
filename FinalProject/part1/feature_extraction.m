function [features] = feature_extraction(selected_files, sift_type, color_space, max_features)

    if nargin == 3
        max_features = -1;
    end
    
    features = [];
    total = 4 * size(selected_files, 2);
    for c=1:4
        for f=1:size(selected_files, 2)
            current = (c-1)*size(selected_files, 2) + f;
            if current > 1
                fprintf(repmat('\b', 1, progress_length));
            end
            progress = sprintf('%d of %d', current, total);
            progress_length = size(progress, 2);
            fprintf(progress);
            image = imread(sprintf('Caltech4/ImageData/%s.jpg', selected_files(c, f)));
            image = im2single(image);
            
            D = get_features(image, sift_type, color_space);
            features = [features; D];
        end
    end  
    
    if size(features, 1) > max_features && max_features > 0
        features = random_rows(features, max_features);
    end
    
    features = double(features);
end

function [new] = random_rows(matrix, n)
    k = randperm(size(matrix, 1));
    new = matrix(k(1:n),:);
end