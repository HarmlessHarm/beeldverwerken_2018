%% Lab 4
% Team: Harm Manders, Hannah Min
clc
disp('Lab 4 by Harm Manders and Hannah Min')
addpath('attachments/')
% My vlfeat install
run('~/vlfeat-0.9.20/toolbox/vl_setup.m')
%% 2 Projectivity
% Run mosaic script with our own projection matrix code
% Preprogrammed xy and xaya (uv)
figure(1)
demo_mosaic
title('Demo')

%% 3 SIFT
% Nachtwacht images
f1 = imread('nachtwacht1.jpg');
f2 = imread('nachtwacht2.jpg');
% Self made maslow images
m1 = imread('maslow1.jpg');
m2 = imread('maslow2.jpg');



figure(2)
matchN = 4;
[keypts_1, keypts_2] = sift_keypts(f1, f2, matchN);
xy = keypts_1(1:2,1:match_N);
uv = keypts_2(1:2,1:match_N);
subplot(3,2,[3,4]);
mosaic(xy,uv,f1,f2);
title('Sift with top 4 keypoints')

% Maslow bar images.
figure(3)
matchN = 4;
[keypts_1_mas, keypts_2_mas] = sift_keypts(m1, m2, matchN);
xy = keypts_1_mas(1:2,1:match_N);
uv = keypts_2_mas(1:2,1:match_N);
subplot(3,2,[3,4]);
mosaic(xy,uv,m1,m2);
title('Sift with top 4 keypoints')

%% RANSAC
% Used 5 as a threshold for ransac inliers

% ransac parameters for nachtwacht image based on:
% 70% inliers and 4 points to sample
% So: log(1−0.999)÷log(1−(0.7)^4) = 25
[xy, uv] = ransac(keypts_1, keypts_2, 25, 5, 0.7);
figure(2)
subplot(3,2,[5,6])
mosaic(xy,  uv, f1, f2)
title('Ransac')
%%
% rancsac parameters for maslow bar image based on: 
% 40% inliers and 4 points to sample
% So: log(1−.999)÷log(1−(0.4)^4) = 266
[xy, uv] = ransac(keypts_1_mas, keypts_2_mas, 266, 3, 0.4);
figure(3)
subplot(3,2,[5,6])
mosaic(xy,  uv, m1, m2)
title('Ransac')







