clear
clc
close all

%% User defined parameters
num_images = 10;            % number of images used in vocabulary
k = 400;                    % k value for k-means clustering
sift_type = 'normal';       % the sift type
                            % 'normal' 'dense'
color_space = 'gray';       % color space to be used
                            % 'gray' 'RGB' 'rgb' 'opponent'
                            

%% Read the input images and process them for various setup
file_names = get_file_names(num_images);

%% Feature extraction and description
features = feature_extraction(file_names, sift_type, color_space);

%% Build visual vocabulory
% vocab = build_visual_vocab(features, k);
% save(sprintf('vocab/%d_images_%d_vocabsize.mat', num_images, k), 'vocab')

%% Quantize the features using the visual vocabulory
quantization(vocab, image);

%% Image representation
representation();

%% Classification
classification();
