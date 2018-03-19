clear
clc
close all

%% Read the input images and process them for various setup
data_processing();

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
