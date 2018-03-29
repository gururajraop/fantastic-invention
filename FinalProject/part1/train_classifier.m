function [classifier] = train_classifier(class, n, unselected_files, vocab, sift_type, color_space)

    % create list of k positive examples
    % create list of k negative examples per remaining class
    neg_examples = [];
    for i=1:4
        if i == class
            pos_examples = unselected_files(class, 1:n);
        else
            neg_examples = [neg_examples; unselected_files(i, 1:n)];
        end        
    end
    neg_examples = reshape(neg_examples, 1, []);
    
    features = zeros(n*4, size(vocab, 1));
    labels = zeros(n*4, 1);
    
    disp('Feature extraction for training');
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
    
    disp('Started the training');
    best = train(labels, sparse(features), '-C -s 0 -q');
    classifier = train(labels, sparse(features), sprintf('-c %f -s 0 -q', best(1)));
end