clear
clc
close all

%% User defined parameters
num_images = 250;           % number of images used in vocabulary
k = 400;                    % k value for k-means clustering
sift_type = 'dense';        % the sift type
                            % 'normal' 'dense'
color_space = 'gray';       % color space to be used
                            % 'gray' 'RGB' 'rgb' 'opponent'
train_set_size = 5;        % Number of images to be used for each class in
                            % training the classifier
                            
%% Build all types of vocabulary and save them
% build_all_vocab();

%% Read the input images and process them for various setup
% [file_names, remaining] = get_file_names(num_images);

%% Feature extraction and description
% features = feature_extraction(file_names, sift_type, color_space);

%% Build visual vocabulory
% vocab = build_visual_vocab(features, k);

%% Image representation
% representation();

%% Classification
load(sprintf('vocab/%d_images_%d_vocabsize_%s_%s.mat', num_images, k, sift_type, color_space), 'vocab');
% load(sprintf('vocab/unselected-%d_images_%s_%s.mat', num_images, sift_type, color_space), 'unselected');
% classifiers = classification(unselected, vocab, sift_type, color_space, train_set_size);
% save('classifiers/classifiers.mat', 'classifiers');

%% Evaluation
test_size = 50;
[files, ~] = get_file_names(test_size, 'test');
load('classifiers/classifiers.mat', 'classifiers');
evaluation(files, classifiers, test_size, vocab, k, sift_type, color_space)
