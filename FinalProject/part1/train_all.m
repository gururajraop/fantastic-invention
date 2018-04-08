function [] = train_all()
sift_types = ["normal", "dense"];
color_spaces = [ "gray", "RGB", "nrgb",  "opponent"];
k_values = [400, 800, 1600, 2000, 4000];
num_images = 250;
train_set_size = 50;

%% All sift types
for sift = sift_types
    for color = color_spaces
        for k = k_values
            try
                disp(sprintf('Training for vocab: %d_images_%d_vocabsize_%s_%s', num_images, k, sift, color));
                load(sprintf('vocab/%d_images_%d_vocabsize_%s_%s.mat', num_images, k, sift, color), 'vocab');
                load(sprintf('vocab/unselected-%d_images_%s_%s.mat', num_images, sift, color), 'unselected');
                tic
                classifiers = train_classifier(train_set_size, unselected, vocab, sift, color);
                toc
                save(sprintf('classifiers/classifier_%d_images_%d_vocabsize_%s_%s.mat', num_images, k, sift, color), 'classifiers');
            catch e
                warning('Error! Training vocab classifier_%d_images_%d_vocabsize_%s_%s\n%s', num_images, k, sift, color, e.message);
            end
        end
    end
end
            
end
