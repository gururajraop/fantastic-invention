function [] = harris_corner()
% Demo function for Harris Corner detection algorithm

%% Control settings
image_id = 'pingpong';      % Image IDs to switch between input test images
                            % Options: 'person_toy' and 'pingpong'
                            
Gd_type = 'sobel';          % Type of the gaussian derivative function to be used
                            % Options: 'sobel' and 'matlab'
                            
sigma = 2;                  % Gaussian smoothing parameter, sigma
                            
threshold = 0.025;          % User defined threshold for corner point selection

n = 5;                      % Neighboring window

rotate = false;             % Rotate the input image

%% Read input image
switch image_id
    case 'person_toy'
        image = imread('./person_toy/00000001.jpg');
        
    case 'pingpong'
        image = imread('./pingpong/0000.jpeg');
end

if rotate
    image = imrotate(image, randi([0, 360]));
end

% Display input test image
% figure(1), imshow(image); title('Harris Corner input image');

%% Apply Harris Corner Detector Algorithm 
imgray = im2double(rgb2gray(image));
H = harris_corner_detector(imgray, Gd_type, sigma, n, threshold, true);

%% Display results
figure(3), imshow(image); title('Harris Corner detector: output image');
hold on
plot(H(:,1), H(:,2), 'bo', 'MarkerSize', 10);

%% matlab Harris Corner output
C = corner(imgray);
figure(4), imshow(image); title('Harris Corner matlab output image');
hold on
plot(C(:,1), C(:,2), 'ro', 'MarkerSize', 10);

end