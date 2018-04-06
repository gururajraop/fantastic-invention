function [] = fill_template(files, score, set_size)
    [~, idx] = sort(score);

    file_name = fileread('reports/template.html');
    replace_field('{{VOCAB_SIZE}}', '123');
    replace_field('{{SIFT_METHOD}}', 'dense');
%     replace_field('', '');

%     Update the images for the airplane column
    for i=1:4
        for j=1:set_size
            pos = (i-1) * set_size + j;
            source = sprintf('airplanes_test/{{air%d}}', pos);
            if mod(idx(pos), set_size) == 0
                x = floor(idx(pos) / set_size);
                y = 1;
            else
                x = floor(idx(pos) / set_size) + 1;
                y = mod(idx(pos), set_size) + 1;
            end
            destination = files(x, y);
            replace_field(source, destination);
        end
    end
    
%     Update the images for the cars column
    for i=1:4
        for j=1:set_size
            pos = (i-1) * set_size + j;
            source = sprintf('cars_test/{{car%d}}', pos);
            if mod(idx(pos), set_size) == 0
                x = floor(idx(pos) / set_size);
                y = 1;
            else
                x = floor(idx(pos) / set_size) + 1;
                y = mod(idx(pos), set_size) + 1;
            end
            destination = files(x, y);
            replace_field(source, destination);
        end
    end
    
%     Update the images for the faces column
    for i=1:4
        for j=1:set_size
            pos = (i-1) * set_size + j;
            source = sprintf('faces_test/{{face%d}}', pos);
            if mod(idx(pos), set_size) == 0
                x = floor(idx(pos) / set_size);
                y = 1;
            else
                x = floor(idx(pos) / set_size) + 1;
                y = mod(idx(pos), set_size) + 1;
            end
            destination = files(x, y);
            replace_field(source, destination);
        end
    end
    
%     Update the images for the motorbikes column
   for i=1:4
        for j=1:set_size
            pos = (i-1) * set_size + j;
            source = sprintf('motorbikes_test/{{bike%d}}', pos);
            if mod(idx(pos), set_size) == 0
                x = floor(idx(pos) / set_size);
                y = 1;
            else
                x = floor(idx(pos) / set_size) + 1;
                y = mod(idx(pos), set_size) + 1;
            end
            destination = files(x, y);
            replace_field(source, destination);
        end
    end
    
    fn = sprintf('%s-%s.html', 'dense', 'rgb');
    output = fopen(fn, 'w');
    fprintf(output, file_name);
    
    function replace_field(field, value)     
       file_name = strrep(file_name, field,  value);
    end

end


