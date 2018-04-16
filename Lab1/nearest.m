function gray = nearest(image, m, n)
    
    rgb = impixel(image, round(m), round(n));
    gray = rgb(:,1);
    return;
end 