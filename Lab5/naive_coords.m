function naive_coords = naive_coords(images, X_train, X_test)
% Returns a matrix with the nearest neighbours for each of the test images
    naive_coords = zeros(2,size(X_test,2));
% Calculates the distances from one test image in to all train images.
    for i = 1:size(X_test,2)
       dist = sqrt(sum((X_train - X_test(:,i)).^2));
       minimum_dist = min(dist);
       trainInd = find(dist == minimum_dist);
       coords = images{trainInd}.position;
       naive_coords(:,i) = coords';
    end
    return;
end