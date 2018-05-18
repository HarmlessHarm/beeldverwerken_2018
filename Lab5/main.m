%% Lab 5
% Team: Harm Manders, Hannah Min.
% Harm is echt heeel lief!
% Nee jij bent heel lief!
clc
clear
addpath('attachments/');
load('omni.mat')

%% Split data into test and training set
train = 300;
test = length(images) - train;

imdims = size(images{1}.img);

X_train = zeros(numel(images{1}.img),train);
pos_train = zeros(2,train);

for i = 1:train
    s = images{i};
    X_train(:,i) = reshape(s.img,numel(s.img),1);
	pos_train(:,i) = s.position';
end
X_test = zeros(numel(images{1}.img),length(images)-train);
size(X_test)
pos_test = zeros(2,length(images)-train);
for i = train+1:length(images)
    s = images{i};
    X_test(:,i-train) = reshape(s.img,numel(s.img),1);
	pos_test(:,i) = s.position';
end
size(X_test)

%% Apply PCA to train set

X_mean = mean(X_train, 2);
X_train = X_train - X_mean;
tic
[U,S,V] = svd(X_train);
toc
% Slow approach:  U(XX') = U(X)
tic
% [U,D] = eigs(X_train * X_train',50);
toc
%%
figure(1)
disp('U')
size(U)
for i = 1:9
    im = reshape(U(:,i),imdims);
    subplot(3,3,i)
    imshow(im,[])
end
figure(2)
% First 50 eigen values
Eigenvals = sum(S(:,1:150)).^2;
plot(Eigenvals)

%%
k = 250;

Scores = U(:,1:k)' * X_train;
Images = U(:,1:k) * Scores;

figure(4)
imshow(reshape(Images(:,1),imdims), [])
figure(5)
imshow(reshape(X_train(:,1), imdims),[])
figure(6)
imshow(images{1}.img, [])

%%
pca_t = 0;
img_t = 0;
N = 100;
for i = 1:N
r = randsample(550,1);
im = reshape(images{r}.img, prod(imdims), 1);
im_mean = im  - X_mean;
tic
pcaSpace = U(:,1:k)' * im_mean;
dists = sqrt(sum((Scores - pcaSpace).^2));
find(dists == min(dists));
pca_t = pca_t + toc;

tic
dists = sqrt(sum((X_train - im_mean).^2));
find(dists == min(dists));
img_t = img_t + toc;

end

round(pca_t / N, 5)
round(img_t / N, 5)

% +/- 10 speed increase

% You see a dip in distance to 0 at own index.


%% Positioning with Nearest Neighbour

pcaTrain = U(:,1:k)' * X_train;
pcaTest = U(:,1:k)' * X_test;

nearestCoordinates = zeros(2,length(pcaTest));

for i = 1:length(pcaTest)
    
   dist = sqrt(sum((pcaTrain - pcaTest(:,i)).^2));
   minimum_dist = min(dist);
   trainInd = find(dist == minimum_dist);
   coords = images{trainInd}.position;
   nearestCoordinates(:,i) = coords';
    
end

figure(7)
imagestruct = [images{:}];
positions = vertcat(imagestruct.position)';
scatter(positions(1,1:train), positions(2,1:train), 'r')
hold on
scatter(nearestCoordinates(1,:), nearestCoordinates(2,:), 'b')
scatter(positions(1,train+1:end), positions(2,train+1:end), 'g')
hold off

euclidean = sqrt(sum((nearestCoordinates - positions(:,train+1:end)).^2));
sum(euclidean > 150)

