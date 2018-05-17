function projMatrix = estimateProjectionMatrix(xy, XYZ)
    
    x = xy(:,1);
    y = xy(:,2);
    u = XYZ(:,1);
    v = XYZ(:,2);
    w = XYZ(:,3);
    o = ones(size(x));
    z = zeros(size(x));

    Aoddrows = [u,v,w,o,z,z,z,z,-x.*u,-x.*v,-x.*w,-x];
    Aevenrows = [z,z,z,z,u,v,w,o,-y.*u,-y.*v,-y.*w,-y];
    A = [Aoddrows;Aevenrows];

    [~,~,V] = svd(A);
    projMatrix = V(:,end)';
    projMatrix = projMatrix ./ projMatrix(12);
    projMatrix = reshape(projMatrix, 4,3)';
    
end