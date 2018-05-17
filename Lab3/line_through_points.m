function l = line_through_points ( points )
    % returns :
    % l - homogeneous representation of the least -square -fit
%     points = points
    points = points(:,1:2);
    centroid = mean(points);

    rel_points = points - centroid;
    
    C = rel_points' * rel_points;
    [Q,~] = eig(C);
    
    n = Q(:,1);
    d = centroid * n;
    
    p_min = points(1,1:2);
    p_max = points(end,1:2);
    
    l_begin = p_min - ((p_min * n - d) * n)';
    l_end = p_max - ((p_max * n - d) * n)';
    hold on;
    plot([l_begin(1),l_end(1)],[l_begin(2),l_end(2)]);
    hold off;
%     l = d * n;

    l = cross([l_begin,1], [l_end,1]);
end