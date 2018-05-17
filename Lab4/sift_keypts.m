function [keypts_1, keypts_2] = sift_keypts(f1, f2, match_N)
    
    I1 = im2single(rgb2gray(f1));
    I2 = im2single(rgb2gray(f2));

    % Generate features and descriptors for both images
    [F1, D1] = vl_sift(I1);
    [F2, D2] = vl_sift(I2);
    
    % Get all keypoint matches for both descriptors with their scores
    [M, S] = vl_ubcmatch(D1, D2);
    % Sort both M and S according to S (the score vector)
    [~, S_order] = sort(S);
    M_sorted = M(:,S_order);
    
    % Plot the keypoint features on image 1
    subplot(3,2,1)
    imshow(I1)
    keypts_1 = F1(:,M_sorted(1,:));
    h1 = vl_plotframe(keypts_1);
    set(h1,'color','y','linewidth',2) ;
    % Plot the best 4 in red
    hC1 = vl_plotframe(keypts_1(:,1:match_N));
    set(hC1,'color','r','linewidth',3) ;
    title('Image 1 keypoints')

    % Plot the keypoint features on image 2
    subplot(3,2,2)
    imshow(I2)
    keypts_2 = F2(:,M_sorted(2,:));
    h2 = vl_plotframe(keypts_2);
    set(h2,'color','y','linewidth',2);
    % Plot the best 4 in red
    hC2 = vl_plotframe(keypts_2(:,1:match_N));
    set(hC2,'color','r','linewidth',3);
    title('Image 2 keypoints')

end