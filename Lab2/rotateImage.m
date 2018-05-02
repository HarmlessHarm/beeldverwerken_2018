function rotatedImage = rotateImage(image, angle, method, border)

    [Mdim, Ndim] = size(image);
    [newM, newN] = resize_dims(Mdim, Ndim, angle);
    new_image = zeros(newM, newN);
    new_center = [(newM+1)/2;(newN+1)/2;1];
    
    centerImage = [(Mdim+1)/2;(Ndim+1)/2;1];
    
    bor_image = addBorder(image, angle, border);
    [borM, borN] = size(bor_image);
    bor_center = [(borM+1)/2;(borN+1)/2;1];
    % Create the necessary rotation matrix
    invR = [cos(-angle), -sin(-angle),0;
            sin(-angle), cos(-angle), 0;
            0, 0, 1];



    N = reshape(repmat((1:newN), newM, 1), 1, newM * newN);
    M = repmat((1:newM), 1, newM);
    Z = ones(1, newM*newN);

    coords = [M ; N; Z];
    % Obtain colors for the whole rotatedImage matrix
    rotated = invR * (coords - new_center) + bor_center;
    
    % using the specified interpolation method
    values = pixelValue(bor_image, rotated(1,:), rotated(2,:), method);
    rotatedImage = reshape(values, newM, newN);

    return;
end