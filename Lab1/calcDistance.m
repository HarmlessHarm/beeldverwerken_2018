function dist = calcDistance(image, angle, method)

    % rotate image back and forth and compare to bordered image
    r = rotateImage(image, angle, method, 'const');
    r = rotateImage(r, -angle, 'const');
    b = addBorder(image, angle, 'const');
    % Remove NaN values that occur on border and calc distance
    r(isnan(r)) = 0;
    dist = sum(sum((b-r)^2));
    return;

end