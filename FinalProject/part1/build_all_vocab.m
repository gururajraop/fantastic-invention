function [] = build_all_vocab()
sift_types = ["normal", "dense"];
color_spaces = [ "RGB", "nrgb",  "opponent", "gray"];
k_values = [400, 800, 1600, 2000, 4000];
num_images = 250;
max_f = 1000000;

%% Normal SIFT type
% for color = color_spaces
%     [file_names, unselected] = get_file_names(num_images);
%     save(sprintf('vocab/unselected-%d_images_%s_%s.mat', num_images, sift_types{1}, color), 'unselected');
%     save(sprintf('vocab/selected-%d_images_%s_%s.mat', num_images, sift_types{1}, color), 'file_names');
%     fprintf('Feature extraction: %s\n', color);
%     tic;
%     features = feature_extraction(file_names, sift_types{1}, color, max_f);
%     toc;
%     for k = k_values
%         try
%             disp('Building vocab');
%             tic;
%             vocab = build_visual_vocab(features, k);
%             toc;
%             save(sprintf('vocab/%d_images_%d_vocabsize_%s_%s.mat', num_images, k, sift_types{1}, color), 'vocab');
%         catch e
%             warning('ERROR! Failed to build vocab %d_images_%d_vocabsize_%s_%s.mat\n%s', num_images, k, sift_types{1}, color, e.message);
%         end
%     end
% end


%% Dense SIFT type
% for color = color_spaces
%     [file_names, unselected] = get_file_names(num_images);
%     save(sprintf('vocab/unselected-%d_images_%s_%s.mat', num_images, sift_types{2}, color), 'unselected');
%     save(sprintf('vocab/selected-%d_images_%s_%s.mat', num_images, sift_types{2}, color), 'file_names');
%     fprintf('Feature extraction: %s\n', color);
%     tic;
%     features = feature_extraction(file_names, sift_types{2}, color, max_f);
%     toc;
%     for k = k_values
%         try
%             disp('Building vocab');
%             tic;
%             vocab = build_visual_vocab(features, k);
%             toc;
%             save(sprintf('vocab/%d_images_%d_vocabsize_%s_%s.mat', num_images, k, sift_types{2}, color), 'vocab');
%         catch e
%             warning('ERROR! Failed to build vocab %d_images_%d_vocabsize_%s_%s.mat\n%s', num_images, k, sift_types{2}, color, e.message);
%         end
%     end
% end

end

