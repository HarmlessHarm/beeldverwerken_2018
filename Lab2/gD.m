function f = gD(f, sigma, xorder, yorder)

%     d = [1,-1];
    g = gauss1(sigma);
    M = (size(g,2)-1) / 2;
    x = -M:M;
    g1 = -x/sigma^2 .* g;
    g2 = (x.^2/sigma^4 - 1 / sigma^2) .* g;

    if xorder == 1
        f = imfilter(f, g1, 'conv', 'replicate');
    elseif xorder == 2
        f = imfilter(f, g2, 'conv', 'replicate');
    end
    if yorder == 1
        f = imfilter(f, g1', 'conv', 'replicate');
    elseif yorder == 2
        f = imfilter(f, g2', 'conv', 'replicate');
    end
    
    return;
end