function [vocab] = build_visual_vocab(features, k)

    [~, vocab] = kmeans(features, k, 'Replicates', 5);   
end