function [ p, q, SE ] = check_integrability( normals )
    %CHECK_INTEGRABILITY check the surface gradient is acceptable
    %   normals: normal image
    %   p : df / dx
    %   q : df / dy
    %   SE : Squared Errors of the 2 second derivatives

    % initalization
    p = zeros(size(normals, 1), size(normals, 2));
    q = zeros(size(normals, 1), size(normals, 2));
    SE = zeros(size(normals, 1), size(normals, 2));


    % Compute p and q, where
    % [N1, N2, N3] = normal_vector
    % p measures value of df / dx = N1 / N3
    % q measures value of df / dy = N2 / N3
    p = normals(:,:,1) ./ normals(:,:,3);
    q = normals(:,:,2) ./ normals(:,:,3);


    % set invalid values to 0
    p(isnan(p)) = 0;
    q(isnan(q)) = 0;

    % approximate second derivate by neighbor difference
    % and compute the Squared Errors SE of the 2 second derivatives SE

    % take derivative in row and column wise manner
    p_sec = diff(p, 1, 2);
    q_sec = diff(q, 1, 1);

    % diff() removes one row/colum, pad p/q with zeros
    padding_x = size(normals, 1);
    padding_y = size(normals, 2);
    q_sec(padding_x,:)= zeros(1, padding_y);
    p_sec(:,padding_y)= zeros(padding_x, 1);

    % Calculate squared error
    SE = (p_sec - q_sec).^2;

end


