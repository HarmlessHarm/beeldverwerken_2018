function projMatrix = createProjectionMatrix(xy, uv)

    x = xy(:,1);
    y = xy(:,2);
    
    u = uv(:,1);
    v = uv(:,2);
    o = ones(size(x));
    z = zeros(size(x));
    
    Aoddrows = [u,v,o,z,z,z,-x.*u,-x.*v,-x];
    Aevenrows = [z,z,z,u,v,o,-y.*u,-y.*v,-y];
    A = [Aoddrows; Aevenrows];
    projMatrix = null(A);
    projMatrix = projMatrix / projMatrix(9);
    projMatrix = reshape(projMatrix,3,3)';

    return;
end
