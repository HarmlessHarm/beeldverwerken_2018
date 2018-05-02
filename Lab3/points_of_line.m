function [pts] = points_of_line(points, line, epsilon)
    
    n = 1 / sqrt(sum(line .^2)) * line;
    delta = sqrt(sum(line .^2));
    distance = abs(points * n' - delta);
    
    mask = distance < epsilon;
    pts = mask .* points;
    % delete zero rows
    pts = pts(any(pts,2),:);
    
    return;
end