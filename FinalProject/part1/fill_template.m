function [] = fill_template(files, scores, mAP, set_size, color_space, sift_type, k, step, train_size, vocab_train, block)
 
    map_total = sum(mAP)/4;    
    frac = vocab_train / 1865;

    file_name = fileread('reports/template.html');
    
    if strcmp(sift_type, "dense")
        replace_field('{{SIFT_STEP}}', step);
        replace_field('{{SIFT_BLOCK}}', block);
    else
        replace_field('{{SIFT_STEP}}', '-');
        replace_field('{{SIFT_BLOCK}}', '-');        
    end
    
    replace_field('{{MAP}}', map_total);
    

    replace_field('{{VOCAB_SIZE}}', k);
    replace_field('{{VOCAB_FRAC}}', frac);
    replace_field('{{VOCAB_FRACTION}}', k);
    replace_field('{{SIFT_METHOD}}', sift_type);
    replace_field('{{SVM_POS}}', train_size);
    replace_field('{{SVM_NEG}}', 3*train_size);
    replace_field('{{SVM_KERNEL}}', 'linear');

    % Update the images for the airplane column
    score = scores(1, :);
    replace_field('{{AP_AIR}}', mAP(1));
    replace_field('{{AP_CAR}}', mAP(2));
    replace_field('{{AP_FACE}}', mAP(3));
    replace_field('{{AP_BIKE}}', mAP(4));
    
    [~, idx] = sort(score, 'descend');
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
    score = scores(2, :);
    [~, idx] = sort(score, 'descend');
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
    score = scores(3, :);
    [~, idx] = sort(score, 'descend');
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
    score = scores(4, :);
    [~, idx] = sort(score, 'descend');
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
    
    fn = sprintf('%s-%s-%d.html', color_space, sift_type, k);
    output = fopen(fn, 'w');
    fprintf(output, file_name);
    
    function replace_field(field, value)  
        if isnumeric(value)
            value = num2str(value);
        end
       file_name = strrep(file_name, field,  value);
    end

end

