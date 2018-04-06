%% main function 
clear all;
clc;
close all;

%% fine-tune cnn
global EPOCH;
global BATCH_SIZE;

results = zeros(6, 5);
i = 1;
for b=[50, 100]
    for e=[40, 80, 120]
        
        BATCH_SIZE = b;
        EPOCH = e;

        [net, info, ~] = finetune_cnn();   

        fn = sprintf('net-epoch-%d.mat', EPOCH);
        expdir = sprintf('./data/cnn_assignment-lenet-epoch-%d-batch-%d', EPOCH, BATCH_SIZE);



        %% extract features and train svm
        nets.fine_tuned = load(fullfile(expdir, fn));
        nets.fine_tuned = nets.fine_tuned.net;
        nets.pre_trained = load(fullfile('data', 'pre_trained_model.mat'));
        nets.pre_trained = nets.pre_trained.net; 

        data = load(fullfile(expdir, 'imdb-caltech.mat'));


        %%
        res = train_svm(nets, data);
        res = [EPOCH, BATCH_SIZE, res];
        results(i, :) = res;
        i = i + 1;
    end
end

results
