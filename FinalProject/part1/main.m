%% Setup
clear
clc
close all

% Uncomment one of the sections below, the first sections
% perfoms all steps (extracting features, building vocab, training classifier
% evaluation on test set and creating a report) for a specific given setting.
% The second part does the same thing but for all combination of settings
% as requested in the assignement.

%% Perform all steps for just one single setting:
% num_images = 250;           % number of images used in vocabulary
% k = 400;                    % k value for k-means clustering
% sift_type = 'normal';       % the sift type: 'normal' 'dense'
% color_space = 'RGB';        % color space to be used: 'gray' 'RGB' 'rgb' 'opponent'
% train_set_size = 50;        % Number of images to be used for each class in training the classifier
% test_size = 50;

% [file_names, unselected] = get_file_names(num_images, 'train');
% save(sprintf('vocab/unselected-%d_images_%s_%s.mat', num_images, sift, color), 'unselected');
% save(sprintf('vocab/selected-%d_images_%s_%s.mat', num_images, sift, color), 'file_names');
% features = feature_extraction(file_names, sift, color, max_f);
% vocab = build_visual_vocab(features, k, max_iter, true);
% save(sprintf('vocab/%d_images_%d_vocabsize_%s_%s.mat', num_images, k, sift, color), 'vocab');

% Classification
% classifiers = classification(unselected, vocab, sift_type, color_space, train_set_size);
% save('classifiers/classifiers.mat', 'classifiers');

% Evaluation
% [files, ~] = get_file_names(test_size, 'test');
% [scores, mAP] = evaluation(files, classifiers, test_size, vocab, sift_type, color_space)
% save(sprintf('scores/score_%d_images_%d_vocabsize_%s_%s.mat', num_images, k, sift, color), 'scores');
% save(sprintf('scores/mAP_%d_images_%d_vocabsize_%s_%s.mat', num_images, k, sift, color), 'mAP');
                            
%% Do the same steps as above but for all settings
% build_all_vocab();

% train_all();

% evaluate_all();

