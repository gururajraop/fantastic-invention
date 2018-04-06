clc;
close all;
% DATASTRUCTUE:
% imdb
% imdb.images
% imdb.images.labels
% imdb.images.sets
% imdb.meta
% imdb.meta.sets
% imdb.meta.classes

%% Visualize weights final conv layer fine tuned network
BATCH_SIZE = 100;
EPOCH = 40;

fn = sprintf('./data/cnn_assignment-lenet-epoch-%d-batch-%d/net-epoch-%d.mat', EPOCH, BATCH_SIZE, EPOCH);
fn_imdb = sprintf('./data/cnn_assignment-lenet-epoch-%d-batch-%d/imdb-caltech.mat', EPOCH, BATCH_SIZE);

imdb = load(fn_imdb);
net = load(fn);
net_pre = load('./data/pre_trained_model.mat');
net = net.net;
net_pre = net_pre.net;

net.layers{end}.type = 'softmax';
net_pre.layers{end}.type = 'softmax';

n_in = size(imdb.images.data, 4);
features = zeros(n_in, 64);
features_pre = zeros(n_in, 64);
labels = zeros(n_in, 1);
for i=1:n_in
    res = vl_simplenn(net, imdb.images.data(:, :, :, i));
    res_pre = vl_simplenn(net_pre, imdb.images.data(:, :, :, i));
    features(i, :) = res(end-2).x;
    features_pre(i, :) = res_pre(end-2).x;
    labels(i) = imdb.images.labels(i);   
end

mappedX = tsne(features, labels);
title('Fine-tuned network');
vl_simplenn_display(net)


figure;
mappedX = tsne(features_pre, labels);
title('Pre-trained network');
vl_simplenn_display(net_pre)

