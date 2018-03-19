function [selected_files] = get_file_names(n)
%% User defined parameters
classes = {'airplanes', 'cars', 'faces', 'motorbikes'};
path = './Caltech4/';

%% Read the input image paths
image_list = {};
for class = classes
    file_name = sprintf('%s%s%s%s.txt', path, 'ImageSets/', class{1}, '_train');
    file_list = fopen(file_name, 'r');
    image_list{end+1} = textscan(file_list, '%s');
    fclose(file_list);
end

%% Read the images
selected_files = strings(4, n);
for class=1:4
    perm = randperm(size(image_list{class}{1}, 1));
    select = perm(1:n);
    j = 1;
    for i=select
        selected_files(class, j) = image_list{class}{1}{i};
        j = j + 1;
    end
end

end