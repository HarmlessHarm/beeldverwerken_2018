function color = border(image, M, N, method, border_method)
    [Mdim, Ndim] = size(image);
    
    switch border_method
        case 'const'
            color = 0;
        case 'nearest'
            if M < 1
                M = 1;
            elseif M < Mdim
                M = round(M)
            else
                M = Mdim;
            end
            if N < 1
                N = 1;
            elseif N < Ndim
                N = round(N)
            else
                N = Ndim;
            end
            
            color = image(M, N);           
            
        case 'modulo'
            if M < 1
                M = mod(M - 1, Mdim);
            else
                M = mod(M, Mdim) + 1;
            end
            if N < 1
                N = mod(N - 1, Ndim);
            else
                N = mod(N, Ndim) + 1;
            end
            color = pixelValue(image, M, N, method);
    end
    return;
end