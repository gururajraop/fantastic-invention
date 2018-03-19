function [features] = feature_extraction(selected_files)

    features = [];

    for c=1:4
        for f=1:size(selected_files, 2)
            image = imread(sprintf('Caltech4/ImageData/%s.jpg', selected_files(c, f)));
            image = im2single(image);
            if size(image, 3) > 1
                image_gray = rgb2gray(image);     
            else
                image_gray = image;
            end
            
%             [~, D] = vl_sift(image_gray);
            D = get_features(image_gray, 'normal', 'gray');
            
            features = [features; D'];
        end
    end  
    
    features = double(features);

end