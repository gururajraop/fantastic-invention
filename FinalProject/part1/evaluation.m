function [] = evaluation(test_files, classifiers, test_size, vocab, k, sift_type, color_space)
    scores = zeros(4, 4 * test_size);
    neg_examples = [];
    for class=1:4
        if class == class
            pos_examples = test_files(class, 1:test_size);
        else
            neg_examples = [neg_examples; test_files(class, 1:test_size)];
        end        
    end
    neg_examples = reshape(neg_examples, 1, []);
    
    features = zeros(test_size*4, size(vocab, 1));
    labels = zeros(test_size*4, 1);
    
    i = 1;
    for ex=pos_examples
        fn = sprintf('Caltech4/ImageData/%s.jpg', ex);
        image = im2single(imread(fn));
        [~, histogram] = quantization(vocab, image, sift_type, color_space);
        features(i, :) = histogram;
        labels(i) = 1;
        i = i + 1;
    end
    for ex=neg_examples
        fn = sprintf('Caltech4/ImageData/%s.jpg', ex);
        image = im2single(imread(fn));
        [~, histogram] = quantization(vocab, image, sift_type, color_space);
        features(i, :) = histogram;
        i = i + 1;
    end
    
    disp('Evaluation started');
    for class=1:4
        [class_predicted, accuracy, class_scores] = predict(labels, sparse(features), classifiers{class});
        scores(class, :) = sort(class_scores);
    end
    
    
end