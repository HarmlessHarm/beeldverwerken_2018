function dist = calcDistance(image, angle, method)

    % rotate image back and forth and compare to bordered image
    r = rotateImage(image, angle, method);
    r = rotateImage(r, -angle, method);
    b = addBorder(image, angle);
    % Remove NaN values that occur on border and calc distance
    r(isnan(r)) = 0;
    dist = sum(sum((b-r)^2));
    return;

end