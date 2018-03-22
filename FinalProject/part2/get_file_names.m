function [selected_files, count] = get_file_names(set)
    %% User defined parameters
    classes = {'airplanes', 'cars', 'faces', 'motorbikes'};
    path = './data/Caltech4/';

    %% Read the input image paths
    image_list = {};
    for class = classes
        file_name = sprintf('%s%s%s_%s.txt', path, 'ImageSets/', class{1}, set);
        file_list = fopen(file_name, 'r');
        image_list{end+1} = textscan(file_list, '%s');
        fclose(file_list);
    end

    %% Read the images
    count = [0 0 0 0];
    selected_files = strings(4, 500);
    for class=1:4
        j = 1;
        count(class) = size(image_list{class}{1}, 1);
        for i=1:size(image_list{class}{1})
            selected_files(class, j) = string(image_list{class}{1}{i});
            j = j + 1;
        end
    end

end
