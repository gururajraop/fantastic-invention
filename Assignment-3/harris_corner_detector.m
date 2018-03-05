function [ H ] = harris_corner_detector(image, Gd_type, sigma, n, threshold, plot)
% HARRIS_CORNER_DETECTOR function returns the 
% ARGUMENTS
%   image           Input image
%   Gd_type         Gaussian derivative type
%   sigma           Gaussian smoothing parameter sigma
%   n               Corner detection window size
%   threshold       User defined threshold for corner detection
%   plot            Plot the smoothed gaussian derivatives
%
% OUTPUT
%   H               H matrix of size [] having the rows and columns of the 
%                   detected corner points

%% Compute the smoothed gaussian derivatives of the input image
switch Gd_type
    case 'matlab'
        [Ix, Iy] = imgradientxy(image);
        
    case 'sobel'
        sobel_x = [1, 0, -1; 2, 0, -2; 1, 0, -1];
        sobel_y = sobel_x';
        Ix = imfilter(image, sobel_x, 'conv');
        Iy = imfilter(image, sobel_y, 'conv');
end

% Plot the smoothed derivatives
if plot
    figure(2); 
    subplot(1,2,1), imshow(Ix, []); title('Image derivative Ix');
    subplot(1,2,2), imshow(Iy, []); title('Image derivative Iy');
end

%% Compute the Q matrix elements
A = imgaussfilt((Ix .* Ix), sigma, 'FilterSize', 9, 'Padding', 'symmetric');
B = imgaussfilt((Ix .* Iy), sigma, 'FilterSize', 9, 'Padding', 'symmetric');
C = imgaussfilt((Iy .* Iy), sigma, 'FilterSize', 9, 'Padding', 'symmetric');

%% Compute the H matrix
Corners = ((A .* C) - (B .^ 2)) - 0.04 * ((A + C) .^ 2);

%% Select the corener points
[h, w] = size(Corners);
C_pad = zeros(h+(2*n), w+(2*n));
C_pad(n+1:h+n, n+1:w+n) = Corners;
H = [];
for row=n+1:h
    for col=n+1:w
        if (C_pad(row, col) == max(max(C_pad(row-n:row+n, col-n:col+n)))) ...
                && (C_pad(row, col) > threshold)
            H = [H; [col-n, row-n]];
        end
    end
end

end

