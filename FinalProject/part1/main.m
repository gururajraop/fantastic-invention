%% Setup
clear
clc
close all

% The first section perfoms all steps (extracting features, building vocab,
% training classifier, evaluation on test set and creating a report) for a
% specific given setting. A sample configuration is provided that only
% takes a minute to complete (but has very bad results).
% The second (commented) part does the same thing but for all combination
% of settings as requested in the assignement.

%% Perform all steps for just one single setting:
% the settings as shown below are just a toy example that take only a
% minute to complete, it is here for demonstration purpose

num_images = 5;             % number of images used in vocabulary
k = 401;                    % k value for k-means clustering
sift_type = 'normal';       % the sift type: 'normal' 'dense'
color_space = 'gray';       % color space to be used: 'gray' 'RGB' 'rgb' 'opponent'
train_set_size = 2;         % Number of images to be used for each class in training the classifier
test_set_size = 2;          % number of imates in test set per clas
max_f = 200000;             % maximun number of features
max_iter = 300;             % Number of iterations for kmeans

[file_names, unselected] = get_file_names(num_images, 'train');
save(sprintf('vocab/unselected-%d_images_%s_%s.mat', num_images, sift_type, color_space), 'unselected');
save(sprintf('vocab/selected-%d_images_%s_%s.mat', num_images, sift_type, color_space), 'file_names');
features = feature_extraction(file_names, sift_type, color_space, max_f);
vocab = build_visual_vocab(features, k, max_iter, true);
save(sprintf('vocab/%d_images_%d_vocabsize_%s_%s.mat', num_images, k, sift_type, color_space), 'vocab');

% Classification
classifiers = train_classifier(train_set_size, unselected, vocab, sift_type, color_space);
save(sprintf('classifiers/classifier_%d_images_%d_vocabsize_%s_%s.mat', num_images, k, sift_type, color_space), 'classifiers');

% Evaluation
[test_files, ~] = get_file_names(test_set_size, 'test');
save(sprintf('scores/Test_files_%d_images.mat', num_images), 'test_files');
[scores, mAP] = evaluation(test_files, classifiers, test_set_size, vocab, sift_type, color_space);
save(sprintf('scores/score_%d_images_%d_vocabsize_%s_%s.mat', num_images, k, sift_type, color_space), 'scores');
save(sprintf('scores/mAP_%d_images_%d_vocabsize_%s_%s.mat', num_images, k, sift_type, color_space), 'mAP');
fill_template(test_files, scores, mAP, test_set_size, color_space, sift_type, k, 10, train_set_size, num_images * 4, 3);
                            
%% PART 2
% Do the same steps as above but for all settings stated in the
% report/assignment

% build_all_vocab();% 
% train_all();% 
% evaluate_all();