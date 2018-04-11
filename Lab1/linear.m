function color = linear(image, x, y)

    a = x - floor(x);
    b = y - floor(y);
    size(a)
    size(b)
    k = floor(x);
    l = floor(y);
    
    kl   = (1 - a) .* (1 - b) .* image(k, l);
    kl1  = (1 - a) .* b .* image(k , l + 1);
    k1l1  = a .* b .* image(k + 1, l + 1);
    k1l = a .* (1 - b) .* image(k + 1, l);
    
    color = kl + kl1 + k1l1 + k1l;
    return;
    
end