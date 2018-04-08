function [vocab] = build_visual_vocab(features, k, maxiter, vl_sift)
    if vl_sift
        [vocab, ~] = vl_kmeans(features', k, 'MaxNumIterations', maxiter);
        vocab = vocab';
    else
        [~, vocab] = kmeans(features, k, 'Start', 'cluster', 'maxiter', maxiter);   
    end
end