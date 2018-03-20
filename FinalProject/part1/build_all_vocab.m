function [] = build_all_vocab()
sift_types = ["normal", "dense"];
color_spaces = ["gray", "nrgb", "RGB", "opponent"];
k_values = [400, 800, 1600, 2000, 4000];
num_images = 250;

%% Normal SIFT type
% for color = color_spaces
%     [file_names, unselected] = get_file_names(num_images);
%     save(sprintf('vocab/unselected-%d_images_%s_%s.mat', num_images, sift_types{1}, color), 'unselected');
%     save(sprintf('vocab/selected-%d_images_%s_%s.mat', num_images, sift_types{1}, color), 'file_names');
%     features = feature_extraction(file_names, sift_types{1}, color);
%     for k = k_values
%         try
%             vocab = build_visual_vocab(features, k);
%             save(sprintf('vocab/%d_images_%d_vocabsize_%s_%s.mat', num_images, k, sift_types{1}, color), 'vocab');
%         catch
%             warning('ERROR! Failed to build vocab %d_images_%d_vocabsize_%s_%s.mat', num_images, k, sift_types{1}, color);
%         end
%     end
% end


%% Dense SIFT type
% for color = color_spaces
%     [file_names, unselected] = get_file_names(num_images);
%     save(sprintf('vocab/unselected-%d_images_%s_%s.mat', num_images, sift_types{2}, color), 'unselected');
%     save(sprintf('vocab/selected-%d_images_%s_%s.mat', num_images, sift_types{2}, color), 'file_names');
%     features = feature_extraction(file_names, sift_types{1}, color);
%     for k = k_values
%         try
%             vocab = build_visual_vocab(features, k);
%             save(sprintf('vocab/%d_images_%d_vocabsize_%s_%s.mat', num_images, k, sift_types{2}, color), 'vocab');
%         catch
%             warning('ERROR! Failed to build vocab %d_images_%d_vocabsize_%s_%s.mat', num_images, k, sift_types{2}, color);
%         end
%     end
% end



end

