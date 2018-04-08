function [] = build_all_vocab()
sift_types = ["normal", "dense"];
color_spaces = [ "RGB", "nrgb",  "opponent", "gray"];
k_values = [400, 800, 1600, 2000, 4000];
num_images = 250;
max_f = 200 * num_images * 4;
max_iter = 500;

for sift = sift_types
    for color = color_spaces
        [file_names, unselected] = get_file_names(num_images, 'train');
        save(sprintf('vocab/unselected-%d_images_%s_%s.mat', num_images, sift, color), 'unselected');
        save(sprintf('vocab/selected-%d_images_%s_%s.mat', num_images, sift, color), 'file_names');
        fprintf('Feature extraction: %s\n', color);
        tic;
        features = feature_extraction(file_names, sift, color, max_f);
        toc;
        for k = k_values
            try
                disp('Building vocab');
                tic;
                vocab = build_visual_vocab(features, k, max_iter, true);
                toc;
                save(sprintf('vocab/%d_images_%d_vocabsize_%s_%s.mat', num_images, k, sift, color), 'vocab');
            catch e
                warning('ERROR! Failed to build vocab %d_images_%d_vocabsize_%s_%s.mat\n%s', num_images, k, sift, color, e.message);
            end
        end
    end
end

end

