function color = pixelValue(image, x, y, method, border)
    if inImage(size(image), x, y)
        switch(method)
            case 'nearest'
                color = nearest(image, x, y);
                return;
            case 'linear'
                color = linear(image, x, y);
                return;
        end
    else
        color = border(image, x, y, border);
        return;
    end
end