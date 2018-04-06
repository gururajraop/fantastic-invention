function [] = evaluate_all()
sift_types = ["normal", "dense"];
color_spaces = [ "gray", "RGB", "nrgb",  "opponent"];
k_values = [400, 800, 1600, 2000, 4000];
num_images = 250;
test_set_size = 50;

[test_files, ~] = get_file_names(test_set_size, 'test');

%% Normal SIFT type
for color = color_spaces
    for k = k_values
        try
            disp(sprintf('Evaluating for vocab: %d_images_%d_vocabsize_%s_%s', num_images, k, sift_types{1}, color));
            load(sprintf('vocab/%d_images_%d_vocabsize_%s_%s.mat', num_images, k, sift_types{1}, color), 'vocab');
            load(sprintf('classifiers/classifier_%d_images_%d_vocabsize_%s_%s.mat', num_images, k, sift_types{1}, color), 'classifiers');
            tic
            [scores, mAP] = evaluation(test_files, classifiers, test_set_size, vocab, sift_types{1}, color);
            toc
            save(sprintf('scores/score_%d_images_%d_vocabsize_%s_%s.mat', num_images, k, sift_types{1}, color), 'scores');
            save(sprintf('scores/mAP_%d_images_%d_vocabsize_%s_%s.mat', num_images, k, sift_types{1}, color), 'mAP');
        catch
            warning('Error!! Evaluating vocab classifier_%d_images_%d_vocabsize_%s_%s', num_images, k, sift_types{1}, color);
        end
    end
end

end