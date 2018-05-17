function G = gauss(sigma)
    S = round(2.5 * sigma);
    x = -S:S;
    y = -S:S;
    
    [X,Y] = meshgrid(x,y);
    exp_comp = -(X.^2 + Y.^2)/(2 * sigma^2);
    G = 1/ (2 * pi * sigma^2) * exp(exp_comp);
    return;
end