function [] = evaluation(test_files, classifiers, test_size, vocab, sift_type, color_space)
    scores = zeros(4, 4 * test_size);
    features = zeros(test_size*4, size(vocab, 1));
    labels = zeros(test_size*4, 1);
    
    i = 1;
    for c = 1:4
        for ex=test_files(c, 1:test_size)
            fn = sprintf('Caltech4/ImageData/%s.jpg', ex);
            image = im2single(imread(fn));
            [~, histogram] = quantization(vocab, image, sift_type, color_space);
            features(i, :) = histogram;
            labels(i) = c;
            i = i + 1;
        end
    end
    
    disp('Evaluation started');
    for class=1:4
        class_label = double(labels==class);
        [class_predicted, accuracy, class_scores] = predict(class_label, sparse(features), classifiers{class});
        scores(class, :) = sort(class_scores);
    end
    
    scores
end