close all
clear allx
clc
 
%% Gray5

image_dir = './SphereGray5/';
[image_stack, scriptV] = load_syn_images_color(image_dir);
[h, w, n, ~] = size(image_stack);
fprintf('Finish loading %d images.\n\n', n);

% compute the surface gradient from the stack of imgs and light source mat
disp('Computing surface albedo and normal map...')
[albedo_5_nst, normals_5_nst] = estimate_alb_nrm(image_stack, scriptV, false);
[albedo_5_st, normals_5_st] = estimate_alb_nrm(image_stack, scriptV, true);

[p_5_nst, q_5_nst, SE_5_nst] = check_integrability(normals_5_nst);
[p_5_st, q_5_st, SE_5_st] = check_integrability(normals_5_st);

threshold = 0.005;
SE_5_nst(SE_5_nst <= threshold) = NaN; % for good visualization
SE_5_st(SE_5_st <= threshold) = NaN; % for good visualization
outliers_5_nst = sum(sum(SE_5_nst > threshold));
outliers_5_st = sum(sum(SE_5_st > threshold));

height_map_5_nst = construct_surface( p_5_nst, q_5_nst );
height_map_5_st = construct_surface( p_5_st, q_5_st );

%% Gray25

image_dir = './SphereGray25/';
[image_stack, scriptV] = load_syn_images_color(image_dir);
[h, w, n, ~] = size(image_stack);
fprintf('Finish loading %d images.\n\n', n);

% compute the surface gradient from the stack of imgs and light source mat
disp('Computing surface albedo and normal map...')
[albedo_25_nst, normals_25_nst] = estimate_alb_nrm(image_stack, scriptV, false);
[albedo_25_st, normals_25_st] = estimate_alb_nrm(image_stack, scriptV, true);

[p_25_nst, q_25_nst, SE_25_nst] = check_integrability(normals_25_nst);
[p_25_st, q_25_st, SE_25_st] = check_integrability(normals_25_st);

threshold = 0.005;
SE_25_nst(SE_25_nst <= threshold) = NaN; % for good visualization
SE_25_st(SE_25_st <= threshold) = NaN; % for good visualization
outliers_25_nst = sum(sum(SE_25_nst > threshold));
outliers_25_st = sum(sum(SE_25_st > threshold));

height_map_25_nst = construct_surface( p_25_nst, q_25_nst );
height_map_25_st = construct_surface( p_25_st, q_25_st );


%% Make plots and report outliers

fprintf('5 NST Number of outliers: %d\n\n', outliers_5_nst);
fprintf('5 ST Number of outliers: %d\n\n', outliers_5_st);
fprintf('25 NST Number of outliers: %d\n\n', outliers_25_nst);
fprintf('25 ST Number of outliers: %d\n\n', outliers_25_st);

figure
subplot(2, 2, 1);
imshow(albedo_5_nst);
title('Gray5, no shadow trick');

subplot(2, 2, 2);
imshow(albedo_5_st);
title('Gray5, shadow trick');

subplot(2, 2, 3);
imshow(albedo_25_nst);
title('Gray25, no shadow trick');

subplot(2, 2, 4);
imshow(albedo_25_st);
title('Gray25, shadow trick');

figure
subplot(2, 2, 1);
imshow(norm_norm(normals_5_nst));
title('Gray5, no shadow trick');

subplot(2, 2, 2);
imshow(norm_norm(normals_5_st));
title('Gray5, shadow trick');

subplot(2, 2, 3);
imshow(norm_norm(normals_25_nst));
title('Gray25, no shadow trick');

subplot(2, 2, 4);
imshow(norm_norm(normals_25_st));
title('Gray25, shadow trick');

%% Helper function to normalize normals (code from show_results.m)
function [normal_img] = norm_norm(normals)
    minN = min(min(normals, [], 1), [], 2);
    maxN = max(max(normals, [], 1), [], 2);
    normal_img = (normals - minN) ./ (maxN - minN);
end




