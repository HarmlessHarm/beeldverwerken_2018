function r = myAffine(image, x1,y1,x2,y2,x3,y3, m, n, method)
    r = zeros(m, n);
    
    A = [ x1,y1,1 ; x2,y2,1 ; x3,y3,1 ]'
    B = [  1,1,1  ; 1,m,1 ; n,1,1 ]'
    X = A / B
    
    M = reshape(repmat((1:n), m, 1), 1, m * n);
    N = repmat((1:m), 1, n);
    Z = ones(1, m*n);
    
    coords = [M;N;Z];
    
    new_coords = X * coords;
    values = pixelValue(image, new_coords(1,:), new_coords(2,:), method);
    r = reshape(values, m, n);
    subplot(1,2,1);
    imshow(r);
    subplot(1,2,2);
    imshow(image);
    plotParallelogram(x1,y1,x2,y2,x3,y3);


end