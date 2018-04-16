function gray = linear(image, x, y)

    a = x - floor(x);
    b = y - floor(y);
    
    k = floor(x);
    l = floor(y);
    
    fkl = impixel(image,k,l);
    fkl1 = impixel(image,k , l + 1);
    fk1l1 = impixel(image,k + 1, l + 1);
    fk1l = impixel(image,k + 1, l);
    
    kl   = (1 - a) .* (1 - b) .* fkl(:,1).';
    kl1  = (1 - a) .* b .* fkl1(:,1).';
    k1l1  = a .* b .* fk1l(:,1).';
    k1l = a .* (1 - b) .* fk1l1(:,1).';
    
    gray = kl + kl1 + k1l1 + k1l;
    
    return;
    
end