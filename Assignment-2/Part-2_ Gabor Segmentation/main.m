clear
clc
close all

% Effect of sigma
sigmas = [2, 5, 10, 15, 20];
thetas = [0, (0.125*pi), (0.25*pi), (0.375*pi), (0.499*pi)];
gammas = [0.05, 0.1, 0.2, 0.5, 0.99];

sigma_default = [10, 10, 10, 10, 10];
theta_default = [0.78, 0.78, 0.78, 0.78, 0.78];
gamma_default = [0.5, 0.5, 0.5, 0.5, 0.5];

% Effect of sigma
plotGaborEffect(sigmas, theta_default, gamma_default);

% Effect of theta
plotGaborEffect(sigma_default, thetas, gamma_default);

% Effect of gamma
plotGaborEffect(sigma_default, theta_default, gammas);
