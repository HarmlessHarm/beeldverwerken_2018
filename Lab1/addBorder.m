function borderedImage = addBorder(image, angle, method)

    [mdim, ndim] = size(image);
    
    horSize = round(ndim * cos(angle) * sin(angle));
    verSize = round(mdim * cos(angle) * sin(angle));
    
    switch method
        case 'const'
            horBor = zeros(horSize, mdim);
            verBor = zeros(ndim, verSize);
            corBor = zeros(horSize, verSize);
            borderedImage = [corBor, horBor, corBor;
                     verBor, image,  verBor;
                     corBor, horBor, corBor];
            
        case 'edge'
            horBorTop = repmat(image(1,:), horSize,1);
            horBorBot = repmat(image(mdim,:), horSize,1);
            verBorLeft = repmat(image(:,1), 1,verSize);
            verBorRight = repmat(image(:,ndim), 1,verSize);
            corBorTL = repmat(image(1,1), horSize, verSize);
            corBorTR = repmat(image(1,ndim), horSize, verSize);
            corBorBR = repmat(image(mdim,ndim), horSize, verSize);
            corBorBL = repmat(image(mdim,1), horSize, verSize);
            
            borderedImage = [corBorTL, horBorTop, corBorTR;
                     verBorLeft, image,  verBorRight;
                     corBorBL, horBorBot, corBorBR];
    end

    
    
    return;
end
