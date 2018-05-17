function gray = linear(image, x, y)

    a = x - floor(x);
    b = y - floor(y);
    
    k = floor(x);
    l = floor(y);
    
    fkl = impixel(image,l,k);
    fkl1 = impixel(image,l+1,k);
    fk1l1 = impixel(image,l+1,k + 1);
    fk1l = impixel(image,l,k + 1);
    
    kl   = (1 - a) .* (1 - b) .* fkl(:,1).';
    kl1  = (1 - a) .* b .* fkl1(:,1).';
    k1l1  = a .* b .* fk1l(:,1).';
    k1l = a .* (1 - b) .* fk1l1(:,1).';
    
    gray = kl + kl1 + k1l1 + k1l;
    
    return;
    
end