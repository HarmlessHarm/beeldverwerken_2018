function rotatedImage = rotateImage(image, angle, method)

% Create the necessary rotation matrix
R = [cos(angle), -sin(angle);sin(angle), cos(angle)];
% Obtain indices needed for interpolation
[xdim, ydim] = size(image);
X = reshape(repmat([1:ydim], xdim, 1), 1, xdim * ydim);
Y = repmat([1:xdim], 1, ydim);
Z = ones(1, xdim*ydim);

coords = [X;Y];

% Obtain colors for the whole rotatedImage matrix
rotated = R * (coords - [1;1]) + [1;1];
% using the specified interpolation method
coords([1,2],[1:10])
rotated([1,2],[1:10])
end