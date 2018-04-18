function projMatrix = createProjectionMatrix(xy, uv)
    
    x = xy(:,1)
    y = xy(:,2)
    
    u = uv(:,1)
    v = uv(:,2)
    o = ones(size(x));
    z = zeros(size(x));
    
    Aoddrows = [x,y,o,z,z,z,-u.*x, -u.*y, -u];
    Aevenrows = [z,z,z,x,y,o,-v.*x, -v.*y, -v];
    A = [Aoddrows; Aevenrows]
    
%     [U,S,V] = svd(A);
    V = null(A)
    projMatrix = reshape(V(:,end),3,3);
    A * V(:,end)
%     projMatrix = reshape(projMatrix,3,3);
    return;
end