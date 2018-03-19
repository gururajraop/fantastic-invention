function [vocab] = build_visual_vocab(features, k)
    size(features)
    [~, vocab] = kmeans(features, k, 'Replicates', 5);   
    size(vocab)
end