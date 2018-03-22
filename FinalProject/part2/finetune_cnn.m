function [net, info, expdir] = finetune_cnn(varargin)

%% Define options
% run(fullfile(fileparts(mfilename('fullpath')), ...
%   '..', '..', '..', 'matlab', 'vl_setupnn.m')) ;
run("C:\Users\WilIk\Desktop\matconvnet-1.0-beta25\matlab\vl_setupnn.m");

opts.modelType = 'lenet' ;
[opts, varargin] = vl_argparse(opts, varargin) ;

opts.expDir = fullfile('data', ...
  sprintf('cnn_assignment-%s', opts.modelType)) ;
[opts, varargin] = vl_argparse(opts, varargin) ;

opts.dataDir = './data/' ;
opts.imdbPath = fullfile(opts.expDir, 'imdb-caltech.mat');
opts.whitenData = true ;
opts.contrastNormalization = true ;
opts.networkType = 'simplenn' ;
opts.train = struct() ;
opts = vl_argparse(opts, varargin) ;
if ~isfield(opts.train, 'gpus'), opts.train.gpus = []; end;

% opts.train.gpus = [1];



%% update model

net = update_model();

%% TODO: Implement getCaltechIMDB function below

% if exist(opts.imdbPath, 'file')
%   imdb = load(opts.imdbPath) ;
% else
  imdb = getCaltechIMDB() ;
  mkdir(opts.expDir) ;
  save(opts.imdbPath, '-struct', 'imdb') ;
% end

%%
net.meta.classes.name = imdb.meta.classes(:)' ;

% -------------------------------------------------------------------------
%                                                                     Train
% -------------------------------------------------------------------------

trainfn = @cnn_train ;
[net, info] = trainfn(net, imdb, getBatch(opts), ...
  'expDir', opts.expDir, ...
  net.meta.trainOpts, ...
  opts.train, ...
  'val', find(imdb.images.set == 2)) ;

expdir = opts.expDir;
end
% -------------------------------------------------------------------------
function fn = getBatch(opts)
% -------------------------------------------------------------------------
switch lower(opts.networkType)
  case 'simplenn'
    fn = @(x,y) getSimpleNNBatch(x,y) ;
  case 'dagnn'
    bopts = struct('numGpus', numel(opts.train.gpus)) ;
    fn = @(x,y) getDagNNBatch(bopts,x,y) ;
end

end

function [images, labels] = getSimpleNNBatch(imdb, batch)
% -------------------------------------------------------------------------
images = imdb.images.data(:,:,:,batch) ;
labels = imdb.images.labels(1,batch) ;
if rand > 0.5, images=fliplr(images) ; end

end

% -------------------------------------------------------------------------
function imdb = getCaltechIMDB()
% -------------------------------------------------------------------------
% Preapre the imdb structure, returns image data with mean image subtracted
classes = {'airplanes', 'cars', 'faces', 'motorbikes'};
splits = {'train', 'test'};

[files_train, counts_train] = get_file_names('train');
[files_test, counts_test] = get_file_names('test');
data = zeros(32, 32, 3, sum(counts_train) + sum(counts_test));
cc = 1;
for c=1:4
    for f=1:size(files_train,2)
       fn = files_train(c, f);
       if fn ~= ""
           fn_path = sprintf('./data/Caltech4/ImageData/%s.jpg', fn);
           image = imread(fn_path);
           if size(image, 3) == 1
               new_image = zeros(size(image, 1), size(image, 2), 3);
               new_image(:, :, 1) = image;
               new_image(:, :, 2) = image;
               new_image(:, :, 3) = image;
               image = new_image;               
           end
           image = imresize(image, [32 32]);
           data(:, :, :, cc) = image;
           cc = cc + 1;
       end
    end    
end
% Now for test images
for c=1:4
    for f=1:size(files_test,2)
       fn = files_test(c, f);
       if fn ~= ""
           fn_path = sprintf('./data/Caltech4/ImageData/%s.jpg', fn);
           image = imread(fn_path);
           if size(image, 3) == 1
               new_image = zeros(size(image, 1), size(image, 2), 3);
               new_image(:, :, 1) = image;
               new_image(:, :, 2) = image;
               new_image(:, :, 3) = image;
               image = new_image;               
           end
           image = imresize(image, [32 32]);
           data(:, :, :, cc) = image;
           cc = cc + 1;
       end
    end    
end

labels = [];
c = 1;
for count=counts_train
    labels = [labels, repmat(c, [1, count])];
    c = c + 1;
end
for count=counts_test
    labels = [labels, repmat(c, [1, count])];
    c = c + 1;
end
sets = repmat(1, [1, sum(counts_train)]);
sets = [sets, repmat(2, [1, sum(counts_test)])];

size(data)
size(sets)
size(labels)
%%
% subtract mean
dataMean = mean(data(:, :, :, sets == 1), 4);
data = bsxfun(@minus, data, dataMean);

imdb.images.data = single(data);
imdb.images.labels = single(labels) ;
imdb.images.set = sets;
imdb.meta.sets = {'train', 'val'} ;
imdb.meta.classes = classes;

perm = randperm(numel(imdb.images.labels));
imdb.images.data = imdb.images.data(:,:,:, perm);
imdb.images.labels = imdb.images.labels(perm);
imdb.images.set = imdb.images.set(perm);

end
