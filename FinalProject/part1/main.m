clear
clc
close all

%% Read the input images and process them for various setup
num_images = 10;
k = 400;
file_names = get_file_names(num_images);

%% Feature extraction and description
features = feature_extraction(file_names);

%% Build visual vocabulory
vocab = build_visual_vocab(features, k);
% save(sprintf('vocab/%d_images_%d_vocabsize.mat', num_images, k), 'vocab')

%% Quantize the features using the visual vocabulory
quantization();

%% Image representation
representation();

%% Classification
classification();
