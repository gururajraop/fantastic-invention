%% main function 
clear all;
clc;
close all;

%% fine-tune cnn
global EPOCH;
global BATCH_SIZE;

for e=[40,80,120]
    EPOCH = 40;
    BATCH_SIZE = 100;
    
    [net, info, expdir] = finetune_cnn();   
end




%% extract features and train svm

% TODO: Replace the name with the name of your fine-tuned model
% nets.fine_tuned = load(fullfile(expdir, 'your_new_model.mat')); nets.fine_tuned = nets.fine_tuned.net;
% nets.pre_trained = load(fullfile('data', 'pre_trained_model.mat')); nets.pre_trained = nets.pre_trained.net; 
% data = load(fullfile(expdir, 'imdb-caltech.mat'));
% 
% 
% %%
% train_svm(nets, data);
