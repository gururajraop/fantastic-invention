%% SIFT setup
% Specify the path for vlfeat
VLFEAT_ROOT = 'C:\Users\user\Downloads\MathWorks\vlfeat-0.9.21-bin\vlfeat-0.9.21\';
VLFEAT_ROOT = 'C:\Users\WilIk\Desktop\vlfeat-0.9.21\';
VLFEAT_ROOT = sprintf('%s%s', VLFEAT_ROOT, 'toolbox\vl_setup.m');
run(VLFEAT_ROOT);

matconvpath  = "C:\Users\WilIk\Desktop\matconvnet-1.0-beta25\matlab\vl_setupnn.m";
run(matconvpath)

run(".\part2\liblinear-2.1\matlab\make.m")