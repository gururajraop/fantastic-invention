function [] = tracking(input)
    switch input
        case 'person_toy'
            base = './person_toy/0000';
            ext = 'jpg';
            max = 104;
            start = 1;
            sigma = 2;
            n = 5;
            threshold = 0.025;
            region_s = 25;
            
        case 'pingpong'
            base = './pingpong/';
            ext = 'jpeg';
            max = 52;
            start = 0;
            sigma = 5;
            n = 5;
            threshold = 0.025;
            region_s = 15;
    end
    
    figure
    
    for i = start:max
        filename = sprintf('%s%04i.%s', base, i, ext);
        filename_prev = sprintf('%s%04i.%s', base, i - 1, ext);
        img_org = imread(filename);
        img = im2double(rgb2gray(img_org));    
        
        if i == start %|| mod(i, 15) == 0
            H = harris_corner_detector(img, 'sobel', sigma, n, threshold);
            imshow(img_org); 
            hold on
            plot(H(:,1), H(:,2), 'bo', 'MarkerSize', 10);
            hold off;
        else
            imshow(img_org);
            hold on;
            [u, v] = lucas_kanade(filename_prev, filename, region_s, false);
            H = translate_features(H, u, v, region_s);
            plot(H(:,1), H(:,2), 'bo', 'MarkerSize', 10);
            hold off;
        end

        
        title(sprintf('%i / %i', i, max))        
        pause(0.6);        
    end   
    
end

% u is change in h direction = corresponds with colum 2 in H
% v is change in w direction = corresponds with colum 1 in H
function [H_new] = translate_features(H, u, v, region_s)
    n = size(H, 1);
    [max_h, max_w] = size(u);
    H_new = [];
    
    for i = 1:n
        region_h = floor(H(i, 2) / region_s) + 1;
        region_w = floor(H(i, 1) / region_s) + 1;
        if region_h > 0 && region_w > 0 && region_w <= max_w && region_h <= max_h % A feature can fall out of the image
            H_new(i, :) = [H(i, 1) + v(region_h, region_w), H(i, 2) + u(region_h, region_w)];
        end
    end
end