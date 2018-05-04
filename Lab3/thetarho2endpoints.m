function [ x1 , y1 , x2 , y2 ] = thetarho2endpoints(theta, rho, rows, cols )
    if theta ~= (0.5 * pi)
        x1 = 0;
        x2 = cols;
        y1 = (x1 * sin(theta) - rho) / cos(theta);
        y2 = (x2 * sin(theta) - rho) / cos(theta);
    else
        y1 = 0;
        y2 = rows;
        x1 = (rho + y1 * cos(theta)) / sin(theta);
        x2 = (rho + y2 * cos(theta)) / sin(theta);
    end
    return;
end