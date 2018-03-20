% takes an image and vocab as input and returns a list of words

function [words, histogram] = quantization(vocab, image, sift_type, colorspace)
    features = [];
    features = [features; get_features(image, sift_type, colorspace)];

    words = zeros(size(features));
    histogram = zeros(size(vocab, 1), 1);

    for f=1:size(features, 1)
        feature = features(f, :);        
        [word, ~, word_n] = find_closest_word(feature, vocab);
        words(f, :) = word;
        histogram(word_n, 1) = histogram(word_n, 1) + 1;
    end  
    
    histogram = histogram ./ size(features, 1);
end

function [word, distance, word_n] = find_closest_word(feature, vocab)
    word_n = 1;
    word = vocab(1, :);
    distance = norm(feature, vocab(1, :));
    
    for b = 2:size(vocab, 1)
        distance_next = norm(feature, vocab(b, :));
        if distance_next < distance
            distance = distance_next;
            word = vocab(b, :);
            word_n = b;
        end        
    end
end