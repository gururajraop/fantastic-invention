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
% q = zeros(size(normals));
% SE = zeros(size(normals));

% ========================================================================
% YOUR CODE GOES HERE
% Compute p and q, where
% p measures value of df / dx
% q measures value of df / dy

p = normals(:,:,1) ./ normals(:,:,3);
q = normals(:,:,2) ./ normals(:,:,3);


% ========================================================================



p(isnan(p)) = 0;
q(isnan(q)) = 0;



% ========================================================================
% YOUR CODE GOES HERE
% approximate second derivate by neighbor difference
% and compute the Squared Errors SE of the 2 second derivatives SE

p_sec = diff(p,1,2);
q_sec = diff(q,1,1);

padding_x = size(normals, 1);
padding_y = size(normals, 2);

q_sec(padding_x,:)= zeros(1, padding_y);
p_sec(:,padding_y)= zeros(padding_x, 1);

SE = (p_sec - q_sec).^2;

% ========================================================================


end


