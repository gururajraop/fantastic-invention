function [ albedo, normal ] = estimate_alb_nrm( image_stack, scriptV, shadow_trick)
    %COMPUTE_SURFACE_GRADIENT compute the gradient of the surface
    %   image_stack : the images of the desired surface stacked up on the 3rd
    %   dimension
    %   scriptV : matrix V (in the algorithm) of source and camera information
    %   shadow_trick: (true/false) whether or not to use shadow trick in solving
    %   	linear equations
    %   albedo : the surface albedo
    %   normal : the surface normal


    [h, w, ~, c] = size(image_stack);
    if nargin == 2
        shadow_trick = true;
    end

    % create arrays for 
    %   albedo (c channel)
    %   normal (3 channels)
    albedo = zeros(h, w, c);
    normal = zeros(h, w, 3);

    % for all pixels/colours
    for row = 1:h
        for col = 1:w
            for channel = 1:c
                i = squeeze(image_stack(row, col, :, channel));
                
                % solve system of equations
                if shadow_trick                        
                    scriptI = diag(i);
                    g = (scriptI * scriptV) \ (scriptI * i);
                else
                    g = scriptV \ i;
                end

                % calculate norm and albedo
                albedo(row, col, channel) =  norm(g);
%                 if norm(g) ~= 0
                    normal(row, col, :) = squeeze(normal(row, col, :)) + squeeze(g / norm(g));
%                 end
            end
        end
    end
    
    normal = normal / c;
end