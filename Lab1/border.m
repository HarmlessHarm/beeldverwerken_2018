function color = border(image, x, y, method, border)
    
    [xdim, ydim] = size(image);
    
    switch border
        case 'const'
            color = 0;
        case 'nearest'
            if x < 1
                x = 1;
            else
                x = xdim;
            end
            if y < 1
                y = 1;
            else
                y = ydim;
            end
            
            color = image(x, y);           
            
        case 'modulo'
            if x < 1
                x = mod(x - 1, xdim);
            else
                x = mod(x, xdim) + 1;
            end
            if y < 1
                y = mod(y - 1, ydim);
            else
                y = mod(y, ydim) + 1;
            end
            color = pixelValue(image, x, y, method, border);
    end
    return;
end