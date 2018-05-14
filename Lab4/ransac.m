function [best_xy, best_uv] = ransac(pts1, pts2, iterations, distThresh, inlierRatio)
    % Returns best 4 point combinations to generate a projection matrix
    % from.
    best_xy = zeros(2,4);
    best_uv = zeros(2,4);
    best_num = 0;
    best_err = Inf;
    
    for i = 1:iterations
        % Sample 4 random keypoint-pairs.
        rand_ind = randsample(1:length(pts1), 4, false);
        xy = pts1(1:2,rand_ind);
        uv = pts2(1:2,rand_ind);
        % Generate projection matrix with the 4 point pairs
        proj = createProjectionMatrix(xy', uv');
        hom_pts1 = [pts1(1:2,:);ones(1,length(pts1))];
        % Project all points from image1 to image2.
        new_pts1 =  proj * hom_pts1;
        new_pts1 = new_pts1 ./ new_pts1(3,:);
        
        % Calculate the distance between the projected points and the
        % actual keypoints in image2
        dist = sqrt(sum((pts2(1:2,:) - new_pts1(1:2,:)).^2));
        % Filter outliers
        inlierNum = sum(dist <= distThresh);
        if (inlierNum >= round(inlierRatio * size(pts1, 2)) && inlierNum >= best_num && sum(dist) < best_err)
            % Store best inlier number and lowest distance error as best
            % parameter values.
            best_num = inlierNum;
            best_err = sum(dist);
            best_xy = xy;
            best_uv = uv;
        end
    end
    size(pts1,2)
    best_num
end