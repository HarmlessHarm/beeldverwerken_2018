function G = gauss1(sigma)
    S = round(2.5 * sigma);
    x = -S:S;
    exp_comp = -(x.^2)/(2 * sigma^2);
    G = 1 / (sqrt(2 * pi) * sigma) * exp(exp_comp);
    return;
end