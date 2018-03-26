clc;
close all;

%% Visualize weights final conv layer fine tuned network
net = load("data/cnn_assignment-lenet/net-epoch-10.mat");
net = net.net;

layers = net.layers;
w = layers{end-1}.weights{1};
w = squeeze(w);
mappedX = tsne(w);
scatter(mappedX(:,1), mappedX(:,2), 12, 'red');
hold on;


%% Visualize weights final conv layer pre trained network
netpre = load("data/pre_trained_model.mat");
netpre = netpre.net;

layers = netpre.layers;
w = layers{end-1}.weights{1};
w = squeeze(w);
mappedX = tsne(w);
scatter(mappedX(:,1), mappedX(:,2), 12, 'blue');
legend('Fine tuned', 'Pre trained');

%% Display network Architecture
disp('Pre trained network');
vl_simplenn_display(netpre);
disp('Fine tuned network');
vl_simplenn_display(net);