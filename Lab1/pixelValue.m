function color = pixelValue(image, m, n, method)
%     if inImage(size(image), M, N)
    [mdim, ndim] = size(image);
    m_inImage = m >= 1 & m <= mdim;
    n_inImage = n >= 1 & n <= ndim;
    mask = m_inImage & n_inImage;
    
    %m = m(:,mask);
    %n = n(:,mask);
    
    switch(method)
        case 'nearest'
            color = nearest(image, m, n);
            return;
        case 'linear'
            color = linear(image, m, n);
            return;
    end
end