clear
clc
close all

% Harris-Corner Detector
harris_corner_detector();

% Optical Flow with Lucas-Kanade Algorithm
[v1, v2] = lucas_kanade('sphere1.ppm', 'sphere2.ppm');
% lucas_kanade('synth1.pgm', 'synth2.pgm'); % grey synthetic image

% Feature Tracking
tracking();