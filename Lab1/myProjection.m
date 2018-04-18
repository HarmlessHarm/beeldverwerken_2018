function projection = myProjection(image, xy , m, n, method)

%     projection = zeros(m,n);
%     xy = [x1,y1;x2,y2;x3,y3;x4,y4];
    uv = [1,1;1,n;m,n;m,1];

    projMat = createProjectionMatrix(xy,uv);
    
    N = reshape(repmat((1:n), m, 1), 1, m * n);
    M = repmat((1:m), 1, n);
    Z = ones(1, m*n);
    
    size(M)
    size(N)
    size(Z)
    
    coords = [M;N;Z];
    coords(:,50050)
    new_coords = projMat \ coords;
    new_coords(:,(50050:50100))
    new_coords = new_coords ./ new_coords(3,:);
    new_coords(:,(50050:50100))
    values = pixelValue(image, new_coords(1,:), new_coords(2,:), method);
    
    projection = reshape(values, m,n);
    imshow(projection);
    return;
end
