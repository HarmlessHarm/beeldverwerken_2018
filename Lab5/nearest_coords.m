function nearest_coords = nearest_coords(images, X_train, X_test, U, k)
% Returns a matrix with the nearest neighbours for each of the test images
    pcaTrain = U(:,1:k)' * X_train;
    pcaTest = U(:,1:k)' * X_test;

    nearest_coords = zeros(2,size(pcaTest,2));
% Calculates the distances from one test image in pca base to all train
% images in pca base.
    for i = 1:size(pcaTest,2)
        dist = sqrt(sum((pcaTrain - pcaTest(:,i)).^2));
        minimum_dist = min(dist);
        trainInd = find(dist == minimum_dist);
        coords = images{trainInd}.position; 
        nearest_coords(:,i) = coords';
    end
    return;
end