%% Lab 5
% Team: Harm Manders, Hannah Min.
% 10677186, 11011580
clc
clear
addpath('attachments/');
load('omni.mat')

%% Split data into test and training set
% Transforms every input image to a feature vector and stores them in
% matrix
train = 300;
test = length(images) - train;
% Standard image dimensions
imdims = size(images{1}.img);

X_train = zeros(prod(imdims),train);
for i = 1:train
    s = images{i};
    X_train(:,i) = reshape(s.img,numel(s.img),1);
end

X_test = zeros(prod(imdims),length(images)-train);
for i = train+1:length(images)
    s = images{i};
    X_test(:,i-train) = reshape(s.img,numel(s.img),1);
end

%% Apply PCA to train set

X_mean = mean(X_train, 2);
X_train_hat = X_train - X_mean;
tic
[U,S,V] = svd(X_train_hat);
toc
% Svd(X) in stead of eigs(X'X) gives a 6x speed increase
%% Create first 9 eigen images
figure(1)
for i = 1:9
    im = reshape(U(:,i),imdims);
    subplot(3,3,i)
    imshow(im,[])
end
% First 50 eigen values
figure(2)
Eigenvals = sum(S(:,1:50)).^2;
plot(Eigenvals)
% Elbow method:
% We see a elbow at k=15 so we think 15 eigenvectors should be enough

% Another method for finding k. Calculate when 85% of data resolution is
% achieved by adding up eigenvalues until you reach 85%.
norms = Eigenvals / sum(Eigenvals);
k = 1;
cumsum = 0;
while cumsum < 0.85
    cumsum = cumsum + norms(k);
    k = k + 1;
end
disp(k);
% With k=24 we see that 85% of the data resolution is achieved.


%% Construct an image by means of adding its eigenvectors together.
k = 24;

Scores = U(:,1:k)' * X_train;
Images = U(:,1:k) * Scores;

figure(3)
subplot(2,1,1)
imshow(reshape(Images(:,1),imdims), [])
title('First 24 eigen images of image 1')
subplot(2,1,2)
imshow(reshape(X_train_hat(:,1), imdims),[])
title('How the image - X_{mean} should look')

%% Timing tests for naive and pca vector comparison.
pca_t = 0;
img_t = 0;
N = 100;
for i = 1:N
    r = randsample(550,1);
    im = reshape(images{r}.img, prod(imdims), 1);

    tic
    pcaSpace = U(:,1:k)' * im;
    dists = sqrt(sum((Scores - pcaSpace).^2));
    find(dists == min(dists));
    pca_t = pca_t + toc;

    tic
    dists = sqrt(sum((X_train - im).^2));
    find(dists == min(dists));
    img_t = img_t + toc;

end
figure(4)
pca_t = round(pca_t / N, 5);
img_t = round(img_t / N, 5);
bar([img_t, pca_t], 0.5)
title('Time per image search. left: no pca, right: pca')

% +/- 10-20x speed increase depending on how many eigenvectors are used


%% Would results improve if we were to remove the nearly black borders of our images? Why?
% We think they would improve the PCA algorithm as the border doesn't 
% contain any information but does use up space which in turn slows down 
% the algorithm (More pixels equals more dimensions). So trimming the 
% border would result in a computationally cheaper method.



%% Positioning with Nearest Neighbour

K = 100;
x = 1:K;
y = zeros(1,K);
imagestruct = [images{:}];
positions = vertcat(imagestruct.position)';
for k = 1:K
    nearestCoordinates = nearest_coords(images, X_train, X_test, U, k);
    euclidean = sqrt(sum((nearestCoordinates - positions(:,train+1:end)).^2));
    y(k) = sum(euclidean > 150) / length(euclidean) * 100;
end
figure(5)
plot(x,y)
% You see that there isn't a significant amount of improvement after k=10

nearestCoordinates = nearest_coords(images, X_train, X_test, U, 10);
figure(6)
scatter(positions(1,1:train), positions(2,1:train), 'r')
title('Red: train, Blue: Test estimation, Green: Test actual')
hold on
scatter(nearestCoordinates(1,:), nearestCoordinates(2,:), 'b')
scatter(positions(1,train+1:end), positions(2,train+1:end), 'g')
hold off

%% Benchmarking PCA vs Naive based on error

positions = vertcat(imagestruct.position)';
tic
nearestCoordinates = nearest_coords(images, X_train, X_test, U, 10);
% nearestCoordinates = nearest_coords(images, X_train, X_test, U, 100);
% nearestCoordinates = nearest_coords(images, X_train, X_test, U, 300);
euclidean_nearest = sqrt(sum((nearestCoordinates - positions(:,train+1:end)).^2));
error_nearest = sum(euclidean_nearest > 150) / length(euclidean_nearest) * 100
toc

tic
naiveCoords = naive_coords(images, X_train, X_test);
euclidean_naive = sqrt(sum((naiveCoords - positions(:,train+1:end)).^2));
error_naive = sum(euclidean_naive > 150) / length(euclidean_naive) * 100
toc

% We see that the naive approach gives a better result than our k=10
% approach. Even if we increase k it will be worse then the naive approach.
% But, when we increase k to 300 we see it is equal in error performance.
% This is because there are only 300 training images so there is only a max
% variance in features of 300.
% We do see that time wise the curse of dimensionality is real, even with
% k=300 the pca approach is ~ 35x faster then the naive approach.








