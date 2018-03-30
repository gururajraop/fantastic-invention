function [classifier] = train_classifier(class_id, n, train_files, vocab, sift_type, color_space)
    
    features = zeros(n*4, size(vocab, 1));
    labels = zeros(n*4, 1);
    
    disp('Feature extraction for training');
    i = 1;
    for c = 1:4
        for ex=train_files(c, 1:n)
            fn = sprintf('Caltech4/ImageData/%s.jpg', ex);
            image = im2single(imread(fn));
            [~, histogram] = quantization(vocab, image, sift_type, color_space);
            features(i, :) = histogram;
            labels(i) = c;
            i = i + 1;
        end
    end
    
    classifier = {};
    for class=1:4
        disp(sprintf('Training class %d', class));
        class_label = double(labels==class);
        best = train(class_label, sparse(features), '-C -s 0 -q');
        classifier{end+1} = train(class_label, sparse(features), sprintf('-c %f -s 0 -q', best(1)));
    end
end