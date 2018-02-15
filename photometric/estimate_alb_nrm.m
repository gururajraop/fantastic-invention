function [ albedo, normal ] = estimate_alb_nrm( image_stack, scriptV, shadow_trick)
%COMPUTE_SURFACE_GRADIENT compute the gradient of the surface
%   image_stack : the images of the desired surface stacked up on the 3rd
%   dimension
%   scriptV : matrix V (in the algorithm) of source and camera information
%   shadow_trick: (true/false) whether or not to use shadow trick in solving
%   	linear equations
%   albedo : the surface albedo
%   normal : the surface normal


[h, w, n, c] = size(image_stack);
if nargin == 2
    shadow_trick = true;
end

% create arrays for 
%   albedo (1 channel)
%   normal (3 channels)
albedo = zeros(h, w, 1, c);
normal = zeros(h, w, 3, c);

if shadow_trick
    for row = 1:h
        for col = 1:w
            i = squeeze(image_stack(row, col, :, :));
            scriptI = diag(i);
            g = (scriptI * scriptV) \ (scriptI * i);
            albedo(row, col, 1) =  norm(g);
            normal(row, col, :) = g / norm(g);
        end
    end
else
    for row = 1:h
        for col = 1:w
            i = squeeze(image_stack(row, col, :));
            g = scriptV \ i;
            albedo(row, col, 1) =  norm(g);
            normal(row, col, :) = g / norm(g);
        end
    end
end

end

