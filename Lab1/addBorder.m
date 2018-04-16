function borderedImage = addBorder(image, angle)

    [mdim, ndim] = size(image);
    
    horSize = round(ndim * cos(angle) * sin(angle));
    verSize = round(mdim * cos(angle) * sin(angle));
    
    horBor = zeros(horSize, mdim);
    verBor = zeros(ndim, verSize);
    corBor = zeros(horSize, verSize);
    
    borderedImage = [corBor, horBor, corBor;
                     verBor, image,  verBor;
                     corBor, horBor, corBor];
    return;
end
