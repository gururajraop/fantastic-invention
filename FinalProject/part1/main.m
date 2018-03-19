clear
clc
close all

%% Read the input images and process them for various setup
num_images = 10;
file_names = get_file_names(num_images);

% data_processing(file_names);

%% Feature extraction and description
features = feature_extraction(file_names);

%% Build visual vocabulory
vocab = build_visual_vocab(features, 400);

%% Quantize the features using the visual vocabulory
quantization();

%% Image representation
representation();

%% Classification
classification();
