function [u, v] = lucas_kanade(im1, im2, region_s, fancyplot)
    %% 
    if nargin == 3
        fancyplot = true;
    end

    %%
    % Read image
    im1 = im2double(imread(im1));
    im2 = im2double(imread(im2));
    
    % save ref to original image
    im_org1 = im1;
    im_org2 = im2;
    
    if ~ isequal(size(im1), size(im2))
        error('Images should be of same size')
    end
    
    [h, w, c] = size(im1);
    
    % make it gray if it isnt
    if c ~= 1
        im1 = rgb2gray(im1);
        im2 = rgb2gray(im2);
    end

    %% 
    % Devidide in nonoverlapping regions, truncate parts that don't fill
    % up a complete region
    regions_h = floor(h/region_s);
    regions_w = floor(w/region_s);
    
    max_w = regions_w*region_s;
    max_h = regions_h*region_s;
    
    im1 = im1(1:max_h, 1:max_w);
    im2 = im2(1:max_h, 1:max_w);
    
    % put the images together in one matrix, stack along third dimensions
    im = zeros(max_h, max_w, 2);
    im(:, :, 1) = im1;
    im(:, :, 2) = im2;
    
    %% 
    % Take derrivates in all directions 
    imx = diff(im, 1, 1);
    imx(max_h, :, :) = 0; % We lose one row because of diff function, add a row of 0's
    imy = diff(im, 1, 2);
    imt = diff(im, 1, 3);

    %% For each region calculate optical flow    
    % store flow vectors in two matrices in such a way that the 
    % cells of the matrix correspond to the region in the original image
    u = zeros(regions_h, regions_w);
    v = zeros(regions_h, regions_w);
    
    for region_h = 1:regions_h
        for region_w = 1:regions_w
            % determine index for region
            range_h = (region_h - 1)*region_s+1:region_h*region_s;
            range_w = (region_w - 1)*region_s+1:region_w*region_s;
            
            % Build matrices and solve system of equations
            Ix = reshape(imx(range_h, range_w), [], 1);
            Iy = reshape(imy(range_h, range_w), [], 1);
            A = [Ix Iy];
            b = -1 * reshape(imt(range_h, range_w), [], 1);            
            velocity = (A' * A)\A'*b;
            
            % store results
            u(region_h, region_w) = velocity(1);
            v(region_h, region_w) = velocity(2);
        end
    end
    
    %% PLOT
    if fancyplot        
        fancy_plot(u, v, im_org1, im_org2, region_s, max_h, max_w)
    end

end

%% FANCY_PLOT
% fancy_plot plots first the original images, waits a seconds and then plots the 
% second original image with the optical flow vectors on the images.
% Additionally it plots a grid so that the subregions are visible. Its
% pretty cool
% In case the parameter less_cool is present and true, only the second
% image with grid and motion vectors is shows. Its still cool and fancy but
% not as fancy as without that paramter. Useful when making plots for the
% report.
function [] = fancy_plot(u, v, im_org1, im_org2, region_s, max_h, max_w, less_cool)

    if nargin == 7
        less_cool = false;
    end

    im_org1 = im_org1(1:max_h, 1:max_w, :);
    im_org2 = im_org2(1:max_h, 1:max_w, :);
    
    figure;
    p = gca;
    
    [x, y] = meshgrid(region_s/2:region_s:max_w, region_s/2:region_s:max_h);
    [X, Y] = meshgrid(0:region_s:max_w, 0:region_s:max_h);
    
    first_img = true;
    while ishghandle(p)     
        
        if first_img && ~ less_cool
            imshow(im_org1);  
            hold on;
            plot(X, Y, 'LineStyle', ':', 'color', 'k');
            p = plot(Y, X, 'LineStyle', ':', 'color', 'k');
        else           
            imshow(im_org2);
            hold on
            quiver(x, y, v, u, 'color', [0 0 1]);             
            plot(X, Y, 'LineStyle', ':', 'color', 'k');
            p = plot(Y, X, 'LineStyle', ':', 'color', 'k');
        end
        
        first_img = ~ first_img;
        pause(1)
    end   
end