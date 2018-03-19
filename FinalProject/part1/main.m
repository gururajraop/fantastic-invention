clear
clc
close all

%% Read the input images and process them for various setup
num_images = 10;
file_names = get_file_names(num_images);
data_processing(file_names);

%% Feature extraction and description
feature_extraction();

%% Build visual vocabulory
build_visual_vocab();

%% Quantize the features using the visual vocabulory
quantization();

%% Image representation
representation();

%% Classification
classification();
