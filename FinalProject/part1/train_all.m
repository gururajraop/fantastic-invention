function [] = train_all()
sift_types = ["normal", "dense"];
color_spaces = [ "RGB", "nrgb",  "opponent", "gray"];
k_values = [400, 800, 1600, 2000, 4000];
num_images = 250;
train_set_size = 50;

%% Normal SIFT type
for color = color_spaces
    for k = k_values
        try
            disp(sprintf('Training for vocab: %d_images_%d_vocabsize_%s_%s', num_images, k, sift_types{1}, color));
            load(sprintf('vocab/%d_images_%d_vocabsize_%s_%s.mat', num_images, k, sift_types{1}, color), 'vocab');
            load(sprintf('vocab/unselected-%d_images_%s_%s.mat', num_images, sift_types{1}, color), 'unselected');
            tic
            classifiers = classification(unselected, vocab, sift_types{1}, color, train_set_size);
            toc
            save(sprintf('classifiers/classifier_%d_images_%d_vocabsize_%s_%s.mat', num_images, k, sift_types{1}, color), 'classifiers');
        catch
            warning('Error!! Training vocab classifier_%d_images_%d_vocabsize_%s_%s', num_images, k, sift_types{1}, color);
        end
    end
end

%% Dense SIFT type
% for color = color_spaces
%     for k = k_values
%         try
%             disp('Training the classifier');
%             load(sprintf('vocab/%d_images_%d_vocabsize_%s_%s.mat', num_images, k, sift_types{2}, color), 'vocab');
%             load(sprintf('vocab/unselected-%d_images_%s_%s.mat', num_images, sift_types{2}, color), 'unselected');
%             tic
%             classifiers = classification(unselected, vocab, sift_types{2}, color, train_set_size);
%             toc
%             save(sprintf('classifiers/classifier_%d_images_%d_vocabsize_%s_%s.mat', num_images, k, sift_types{2}, color), 'classifiers');
%         catch
%             warning('Error!! Training vocab classifier_%d_images_%d_vocabsize_%s_%s.mat', num_images, k, sift_types{2}, color);
%         end
%     end
% end
            
end