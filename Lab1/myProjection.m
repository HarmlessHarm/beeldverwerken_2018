function projection = myProjection(image, xy , m, n, method)

    uv = [1,1;n,1;n,m;1,m];
    P = createProjectionMatrix(xy, uv);
    
    M = reshape(repmat((1:n), m, 1), 1, m * n);
    N = repmat((1:m), 1, n);
    Z = ones(1, m*n);
    coords = [M;N;Z];

    new_coords = P * coords;
    new_coords = new_coords ./ new_coords(3,:);
    values = pixelValue(image, new_coords(2,:), new_coords(1,:), method);
    
    projection = reshape(values, m,n);
    return;
end
