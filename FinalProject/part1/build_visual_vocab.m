function [vocab] = build_visual_vocab(features, k)
    [~, vocab] = kmeans(features, k, 'Start', 'cluster', 'maxiter', 500);   
end