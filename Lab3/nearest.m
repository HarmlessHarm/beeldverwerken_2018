function gray = nearest(image, m, n)
    
    rgb = impixel(image, round(n), round(m));
    gray = rgb(:,1);
    return;
end 