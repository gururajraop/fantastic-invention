function [scores, mAP] = evaluation(test_files, classifiers, test_size, vocab, sift_type, color_space)
    scores = zeros(4, 4 * test_size);
    features = zeros(test_size*4, size(vocab, 1));
    labels = zeros(test_size*4, 1);
    
    disp('Feature extraction for evaluation');
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
    mAP = ones(1, 4);
    for class=1:4
        disp(sprintf('Evaluation for class %d', class));
        class_label = double(labels==class);
        [predicted_labels, ~, class_scores] = predict(class_label, sparse(features), classifiers{class});
        shift = test_size * (4-class+1);
        class_labels_shifted = circshift(class_label, shift);
        predicted_labels_shifted = circshift(predicted_labels, shift);
        mAP(class) = get_mAP(class_labels_shifted, predicted_labels_shifted);
    end
    
    disp('Mean average precision for each class is');
    disp(mAP);
end

function [mAP] =  get_mAP(actual_labels, predicted_labels)
    m = sum(actual_labels==1);
    prec = 0;
    count = 0;
    for i=1:length(actual_labels)
        if actual_labels(i) == 1 && predicted_labels(i) == 1
            count = count + 1;
            prec = prec + ( count / i);
        end
    end
    mAP = prec / m;
end
