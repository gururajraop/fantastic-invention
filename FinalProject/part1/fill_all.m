function [] = fill_all()
sift_types = ["normal", "dense"];
color_spaces = [ "gray", "RGB", "nrgb",  "opponent"];
k_values = [400, 800, 1600, 2000, 4000];
num_images = 250;
test_set_size = 50;
train_set_size = 50;

load(sprintf('scores/Test_files_%d_images.mat', num_images), 'test_files');

%% Normal SIFT type
for color = color_spaces
    for k = k_values
            load(sprintf('scores/score_%d_images_%d_vocabsize_%s_%s.mat', num_images, k, sift_types{1}, color), 'scores');
            load(sprintf('scores/mAP_%d_images_%d_vocabsize_%s_%s.mat', num_images, k, sift_types{1}, color), 'mAP');
            fill_template(test_files, scores, mAP, test_set_size, color, sift_types{1}, k, 10, train_set_size, num_images * 4, 3);
    end
end

%% Dense SIFT type
% for color = color_spaces
%     for k = k_values
%             load(sprintf('scores/score_%d_images_%d_vocabsize_%s_%s.mat', num_images, k, sift_types{2}, color), 'scores');
%             load(sprintf('scores/mAP_%d_images_%d_vocabsize_%s_%s.mat', num_images, k, sift_types{2}, color), 'mAP');
%             fill_template(test_files, scores, mAP, test_set_size, color, sift_types{2}, k);
%     end
% end

end