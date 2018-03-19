function [features] = feature_extraction(selected_files, sift_type, color_space)

    features = [];

    for c=1:4
        for f=1:size(selected_files, 2)
            image = imread(sprintf('Caltech4/ImageData/%s.jpg', selected_files(c, f)));
            image = im2single(image);
            
            D = get_features(image, sift_type, color_space);
            features = [features; D'];
        end
    end  
    
    features = double(features);

end